//
//  HTTPRequest.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

class HttpRequest: HTTPRequestRepresentable {
    var isMultipart: Bool?
    var path: String
    var httpMethod: HTTPMethod
    var parameters: [String: Any]?
    var query: [String: String]?
    var body: Data?
    var image: Image?
    var authenticator: Authenticator?
    
    init(path: String, method: HTTPMethod) {
        self.path = path
        self.httpMethod = method
    }
    
    @discardableResult
    func method(_ method: HTTPMethod) -> HttpRequest {
        self.httpMethod = method
        return self
    }
    
    @discardableResult
    func query(_ query: [String: String]) -> HttpRequest {
        self.query = query
        return self
    }
    
    @discardableResult
    func body(_ body: [String: Any]) -> HttpRequest {
        self.parameters = body
        return self
    }
    
    @discardableResult
    func image(_ body: Data, mimeType: String) -> HttpRequest {
        self.image = Image(mimeType: mimeType, data: body)
        return self
    }
    
    @discardableResult
    func auth(_ auth: Authenticator) -> HttpRequest {
        self.authenticator = auth
        return self
    }
}
