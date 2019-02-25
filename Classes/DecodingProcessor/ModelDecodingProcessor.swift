//
//  ModelDecodingProcessor.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

class ModelDecodingProcessor<T: Decodable>: DecodingProcessor {
    typealias DecodingResult = T
    
    func decodeFrom(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: data)
        return model
    }
}
