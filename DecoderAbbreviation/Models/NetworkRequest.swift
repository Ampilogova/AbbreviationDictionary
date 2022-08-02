//
//  NetworkRequest.swift
//  DecoderAbbreviation
//
//  Created by Tatiana Ampilogova on 8/1/22.
//

import Foundation

public struct NetworkRequest {
    
    var url: String
    var parameters = [String: String]()
    
    func buildURL() -> URL? {
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = parameters.map({ URLQueryItem(name: $0, value: $1) })
        
        return urlComponents?.url
    }
}
