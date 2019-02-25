//
//  ResponseHandler.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

enum Result<T, E> {
    case value(T)
    case error(E)
}

protocol ResponseHandler {
    associatedtype ResultType
    associatedtype ErrorType
    
    func handleResponse(_ builder: HTTPRequestRepresentable,
                        completion: @escaping (Result<ResultType, ErrorType>) -> Void)
}
