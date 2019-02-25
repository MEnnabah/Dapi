//
//  HTTPResponse.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

struct HttpResponse: ResponseRepresentable {
    var response: HTTPURLResponse?
    var result: Data?
    var error: Error?
    
    init(response: HTTPURLResponse) {
        self.response = response
    }
    
    init(response: HTTPURLResponse?, result: Data?, error: Error?) {
        self.response = response
        self.result = result
        self.error = error
    }
}
