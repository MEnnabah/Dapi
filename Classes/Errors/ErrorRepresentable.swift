//
//  ErrorRepresentable.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

enum ResponseError: Error {
    case ParseError(String)
}

protocol ErrorRepresentable {
    var message: String { get set }
    var errorCode: Int { get set }
    
    init(_ type: ErrorType)
    init(_ response: ExceptionResponse)
}

enum ErrorType {
    case Undefined
    case NotFound
    case Forbidden
    case InvalidException
    case AuthRequired
    case ParseError
    case ServerError
    case ConnetionError
    
    var descrtiption: String {
        switch self {
        case .Undefined:
            return "Undefined error occured"
        case .NotFound:
            return "Operation isn't avaliable"
        case .Forbidden:
            return "Operation isn't permitted"
        case .InvalidException:
            return "Undefined exception occured"
        case .AuthRequired:
            return "Session is expired. Please, log in"
        case .ParseError:
            return "Invalid response from service"
        case .ServerError:
            return "Service or operation temporary isn't avaliable"
        case .ConnetionError:
            return "Please check you internet connection or try again"
        }
    }
}
