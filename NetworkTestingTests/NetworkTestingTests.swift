//
//  NetworkTestingTests.swift
//  NetworkTestingTests
//
//  Created by Rodrigo Morbach on 15/06/19.
//  Copyright © 2019 Morbach Inc. All rights reserved.
//

import XCTest
@testable import NetworkTesting

class NetworkTestingTests: XCTestCase {
    
    func testDownloadWithSharedSession() {
        // Register Mock class
        URLProtocol.registerClass(URLProtocolMock.self)
        
        // Register expectedURL
        let urlToDownload = URL(string: "http://www.google.com")!
        
        let expectedResponse = """
        {
            "key": "value"
        }
        """
        
        let data = Data(expectedResponse.utf8)
        
        URLProtocolMock.mockedURLs[urlToDownload.absoluteString] = data
        
        let serviceHandler = ServiceHandler()
        
        let session = URLSession.shared
        
        let expectation = XCTestExpectation(description: "Download JSON with default session")
        
        serviceHandler.downloadSomething(from: urlToDownload,
                                         withSession: session) { data, _, _ in
                                            
                                            expectation.fulfill()
                                            
                                            guard let dt = data, let returnedResponse = String(data: dt, encoding: .utf8) else {
                                                XCTFail("Invalid data")
                                                return
                                            }
                                            XCTAssertEqual(returnedResponse, expectedResponse)
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testDownloadWithCustomSession() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        
        // Register expectedURL
        let urlToDownload = URL(string: "http://www.google.com")!
        
        let expectedResponse = """
        {
            "key": "value"
        }
        """
        
        let data = Data(expectedResponse.utf8)
        
        URLProtocolMock.mockedURLs[urlToDownload.absoluteString] = data
        
        let serviceHandler = ServiceHandler()
        
        let session = URLSession(configuration: configuration)
        
        let expectation = XCTestExpectation(description: "Download JSON with custom session")
        
        serviceHandler.downloadSomething(from: urlToDownload,
                                         withSession: session) { data, _, _ in
                                            
                                            expectation.fulfill()
                                            
                                            guard let dt = data, let returnedResponse = String(data: dt, encoding: .utf8) else {
                                                XCTFail("Invalid data")
                                                return
                                            }
                                            XCTAssertEqual(returnedResponse, expectedResponse)
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
