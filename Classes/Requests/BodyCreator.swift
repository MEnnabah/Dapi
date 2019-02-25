//
//  BodyCreator.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        let data = string.data(using: .utf8, allowLossyConversion: false)
        append(data!)
    }
}

struct BodyCreator {
    struct FileData {
        var mimeType: String
        var data: Data
    }
    
    var boundary: String = "Boundary----------------"
    private var boundaryPrefix: String {
        return "--\(boundary)\r\n"
    }
    private var finalBoundary: String {
        return "--\(boundary)--"
    }
    
    private var crlf = "\r\n\r\n"
    private var mcrlf = "\r\n"
    
    init() {
    }
    
    func createBody(parameters: [String: String]? = nil,
                    jsonString: String? = nil,
                    with files: [FileData]? = nil) -> Data {
        var body = Data()
        
        if let parameters = parameters {
            for (key, value) in parameters {
                body.append(boundaryPrefix)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(crlf)")
                body.append("\(value)\(crlf)")
            }
        }
        
        if let json = jsonString {
            let key = "data"
            body.append(boundaryPrefix)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(crlf)")
            body.append("\(json)\(mcrlf)")
        }
        
        if let files = files {
            files.forEach({ appendFile($0, name: "image", to: &body) })
        }
        
        body.append(finalBoundary)
        
        return body as Data
    }
    
    private func appendFile(_ file: FileData, name: String, to body: inout Data) {
        let filenamePrefix = UUID().uuidString
        let filenameExt = file.mimeType.components(separatedBy: "/").last
        let filename = "\(filenamePrefix).\(filenameExt!)"
        
        body.append(boundaryPrefix)
        body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\(mcrlf)")
        body.append("Content-Type: \(file.mimeType)\(crlf)")
        body.append(file.data)
        body.append(crlf)
    }
}
