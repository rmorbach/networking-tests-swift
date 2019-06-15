//
//  URLProtocolMock.swift
//  NetworkTesting
//
//  Created by Rodrigo Morbach on 15/06/19.
//  Copyright © 2019 Morbach Inc. All rights reserved.
//

import Foundation

class URLProtocolMock: URLProtocol {
    
    static var mockedURLs: [String: Data] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let url = request.url {
            if let data = URLProtocolMock.mockedURLs[url.absoluteString] {
                self.client?.urlProtocol(self, didLoad: data)
            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
