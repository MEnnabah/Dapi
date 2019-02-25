//
//  ResponseRepresentable.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

protocol ResponseRepresentable {
    var response: HTTPURLResponse? { get set }
    var result: Data? { get set }
    var error: Error? { get set }
}
