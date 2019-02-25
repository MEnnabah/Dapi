//
//  BaseError.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

class BaseError: ErrorRepresentable {
    var message: String
    var errorCode: Int = 0
    var type: ErrorType
    
    required init(_ type: ErrorType) {
        self.type = type
        self.message = type.descrtiption
    }
    
    required init(_ response: ExceptionResponse) {
        self.errorCode = response.code
        self.message = response.message
        self.type = .Undefined
    }
    
}
