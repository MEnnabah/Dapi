//
//  HTTPRequestRepresentable.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct Image {
    var mimeType: String
    var data: Data
}

protocol HTTPRequestRepresentable {
    var path: String { get set }
    var httpMethod: HTTPMethod { get set }
    var parameters: [String: Any]? { get set }
    var query: [String: String]? { get set }
    var body: Data? { get set }
    var isMultipart: Bool? { get set }
    var authenticator: Authenticator? { get set }
    
    var image: Image? { get set }
}

extension HTTPRequestRepresentable {
    func urlRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: self.path) else {
            return nil
        }
        
        var headers = [String: String]()
        
        var jsonData: Data?
        var bodyData: Data?
        if let params = parameters, params.count > 0 {
            do {
                jsonData = try JSONSerialization.data(withJSONObject: params)
                bodyData = jsonData
            } catch {
                print(error)
            }
        }
        
        if let image = image {
            var jsonString: String?
            if let data = jsonData {
                jsonString = String(data: data, encoding: .utf8)
            }
            let creator = BodyCreator()
            bodyData = creator.createBody(
                jsonString: jsonString,
                with: [BodyCreator.FileData(mimeType: image.mimeType, data: image.data)])
        }
        // TODO: Refactor
        if isMultipart ?? false {
            var jsonString: String?
            if let data = jsonData {
                jsonString = String(data: data, encoding: .utf8)
            }
            let creator = BodyCreator()
            bodyData = creator.createBody(jsonString: jsonString)
        }
        
        if image != nil || (isMultipart ?? false) {
            //
            let boundary = "Boundary----------------"
            headers = ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        } else {
            headers["Content-Type"] = "application/json"
        }
        
        if let parametersJSON = self.query {
            var queryItems = [URLQueryItem]()
            for (key, value) in parametersJSON {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComponents.queryItems = queryItems
        }
        
        authenticator?.appendTokenHeader(toHeaders: &headers)
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        if let body = bodyData {
            urlRequest.httpBody = body
        }
        
        // Set cache policy for request
        urlRequest.cachePolicy = URLRequest.CachePolicy.reloadRevalidatingCacheData
        
        return urlRequest
    }
}
