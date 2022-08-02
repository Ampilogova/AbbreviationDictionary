//
//  NetworkServiceFakeImpl.swift
//  DecoderAbbreviationTests
//
//  Created by Tatiana Ampilogova on 8/1/22.
//

import Foundation
import DecoderAbbreviation

class NetworkServiceFakeImpl: NetworkService {
    
    var data = Data()
    var error: Error?
    
     func send(request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(data))
        }
    }
}
