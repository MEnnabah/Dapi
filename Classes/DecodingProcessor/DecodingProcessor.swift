//
//  DecodingProcessor.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

protocol DecodingProcessor {
    associatedtype DecodingResult
    
    func decodeFrom(_ data: Data) throws -> DecodingResult
}
