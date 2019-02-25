//
//  ExeptionResponse.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

struct ExceptionResponse: Codable {
    var exception: String
    var code: Int
    var message: String
}
