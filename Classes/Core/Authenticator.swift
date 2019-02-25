//
//  Authenticator.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

protocol Authenticator {
    func appendTokenHeader(toHeaders headers: inout [String: String])
}
