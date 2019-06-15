//
//  ServiceHandler.swift
//  NetworkTesting
//
//  Created by Rodrigo Morbach on 15/06/19.
//  Copyright © 2019 Morbach Inc. All rights reserved.
//

import Foundation

class ServiceHandler {
    
    typealias DownloadCompletion = (Data?, URLResponse?, Error?) -> ()
    
    func downloadSomething(from url: URL,
                           withSession session: URLSession,
                           completion: @escaping DownloadCompletion) {
        
        let task = session.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
        
        task.resume()
    }
    
}
