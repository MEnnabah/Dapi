//
//  Loger.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

protocol Loger {
    func logRequest(_ request: HTTPRequestRepresentable)
    func logResponse(_ response: ResponseRepresentable)
}
