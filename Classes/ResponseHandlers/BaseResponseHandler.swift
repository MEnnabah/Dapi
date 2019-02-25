//
//  BaseResponseHandler.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

class BaseResponseHandler<T: Codable, E: ErrorRepresentable>: ResponseHandler {
    typealias ResultType = T
    typealias ErrorType = E
    
    private var loger: Loger = BaseLoger()
    private var client: HttpClientProtocol = SimpleHttpClient()
    private var refreshService: RefreshService?
    
    var isReloginable = true
    
    func handleResponse(_ request: HTTPRequestRepresentable,
                        completion: @escaping (Result<T, E>) -> Void) {
        loger.logRequest(request)
        
        guard let urlRequest = request.urlRequest() else {
            let error = E(.Undefined)
            completion(.error(error))
            return
        }
        
        switch Reach.connectionStatus() {
        case .offline:
            let error = E(.ConnetionError)
            completion(.error(error))
            return
        default:
            DispatchQueue.global(qos: .userInitiated).async {
                let response = self.getResult(urlRequest)
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }
    }
    
    func getResult(_ request: URLRequest) -> Result<T, E> {
        let response = client.execute(request: request)
        loger.logResponse(response)
        
        switch response.response?.statusCode {
        case 200:
            let decodingProcessor = ModelDecodingProcessor<T>()
            if let res = response.result, let result = try? decodingProcessor.decodeFrom(res) {
                return .value(result)
            } else {
                return .error(E(.ParseError))
            }
        case 400:
            let decodingProcessor = ModelDecodingProcessor<ExceptionResponse>()
            if let res = response.result, let result = try? decodingProcessor.decodeFrom(res) {
                return .error(E(result))
            } else {
                return .error(E(.InvalidException))
            }
        case 401:
            //TODO: Add refreshService
            return .error(E(.AuthRequired))
        case 403:
            return .error(E(.Forbidden))
        case 404:
            return .error(E(.NotFound))
        case 500, 501, 502:
            return .error(E(.ServerError))
        default:
            return .error(E(.Undefined))
        }
    }
}
