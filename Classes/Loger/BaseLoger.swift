//
//  BaseLoger.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

struct BaseLoger: Loger {
    func logResponse(_ response: ResponseRepresentable) {
        if let url = response.response?.url {
            print("\nURL Responded: \(url)")
        }
        if let httpResponse = response.response {
            print("    with code: \(httpResponse.statusCode)\n")
        }
    }
    
    func logRequest(_ request: HTTPRequestRepresentable) {
        print("\nSend \(request.httpMethod.rawValue) request...")
        if let url = request.urlRequest()?.url {
            print("   URL: \(url)\n")
        }
    }
}

