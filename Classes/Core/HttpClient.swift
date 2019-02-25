//
//  HttpClient.swift
//  Dapi
//
//  Created by Mac on 25/2/19.
//

import Foundation

protocol HttpClientProtocol {
    func execute(request: URLRequest) -> ResponseRepresentable
}

class SimpleHttpClient: NSObject, HttpClientProtocol {
    
    private var session: URLSession {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        return session
    }
    
    func execute(request: URLRequest) -> ResponseRepresentable {
        let semaphore = DispatchSemaphore(value: 0)
        
        var webResponse = HttpResponse(
            response: nil,
            result: nil,
            error: nil)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                webResponse = HttpResponse(response: httpResponse, result: data, error: error)
                if let fields = httpResponse.allHeaderFields as? [String: String],
                    let url = httpResponse.url {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
                    HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
                } else {
                    print("nil cookies")
                }
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture)
        
        return webResponse
    }
}
