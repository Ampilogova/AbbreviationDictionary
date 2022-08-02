//
//  AbbreviationService.swift
//  DecoderAbbreviation
//
//  Created by Tatiana Ampilogova on 8/1/22.
//

import Foundation

protocol AcronymService {
    ///  Load abbreviation transcript
    func loadAcronymTranscript(acronym: String, completion: @escaping (Result<[AcronymDetails], Error>) -> Void)
}

class AcronymServiceImpl: AcronymService {
    
    private let urlString = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    private let networkService: NetworkService
    private let decoder = JSONDecoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadAcronymTranscript(acronym: String, completion: @escaping (Result<[AcronymDetails], Error>) -> Void) {
        var request = NetworkRequest(url: urlString)
        request.parameters = ["sf": acronym]
        
        networkService.send(request: request) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    if let abbreviations = try self?.decoder.decode([Acronym].self, from: data) {
                        if abbreviations.count != 0 {
                            completion(.success(abbreviations.first?.details ?? []))
                        } else {
                            completion(.failure(NSError("No abbreviation definition found")))
                        }
                    } else {
                        completion(.failure(NSError("Error")))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

