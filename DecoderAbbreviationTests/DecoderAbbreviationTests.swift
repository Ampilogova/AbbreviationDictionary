//
//  DecoderAbbreviationTests.swift
//  DecoderAbbreviationTests
//
//  Created by Tatiana Ampilogova on 8/1/22.
//

import XCTest
@testable import DecoderAbbreviation

class DecoderAbbreviationTests: XCTestCase {
    
    let fakeNetworkService = NetworkServiceFakeImpl()
    
    func testAcronymService() throws {
        
        let data = Data("""
        [{"sf": "FBI", "lfs": [{"lf": "Federal Bureau of Investigation", "freq": 18, "since": 1986, "vars": [{"lf": "Federal Bureau of Investigation", "freq": 17, "since": 1986}, {"lf": "Federal Bureau of Investigations", "freq": 1, "since": 1995}]}, {"lf": "Frontal Behavioral Inventory", "freq": 9, "since": 1997, "vars": [{"lf": "Frontal Behavioral Inventory", "freq": 4, "since": 1997}, {"lf": "Frontal Behavioural Inventory", "freq": 3, "since": 2005}, {"lf": "Frontal Behavior Inventory", "freq": 1, "since": 2005}, {"lf": "frontal behavioural inventory", "freq": 1, "since": 2007}]}, {"lf": "fresh blood imaging", "freq": 7, "since": 2000, "vars": [{"lf": "fresh blood imaging", "freq": 6, "since": 2000}, {"lf": "fresh-blood imaging", "freq": 1, "since": 2001}]}, {"lf": "foreign body infections", "freq": 4, "since": 1998, "vars": [{"lf": "foreign body infections", "freq": 2, "since": 2004}, {"lf": "Foreign-body infection", "freq": 1, "since": 2004}, {"lf": "Foreign-Body Infection", "freq": 1, "since": 1998}]}]}]
        """.utf8)
        fakeNetworkService.data = data
        
        let acronymService = AcronymServiceImpl(networkService: fakeNetworkService)
        var acronyms = [AcronymDetails]()
        acronymService.loadAcronymTranscript(acronym: "FBI") { result in
            switch result {
            case .success(let acronymsResult):
                acronyms = acronymsResult
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertEqual(acronyms.count, 4)
        let acronym = acronyms[0]
        XCTAssertEqual(acronym.fullForms, "Federal Bureau of Investigation")
    }
    
    func testAcronymService_empty() throws {
        let data = Data("""
        []
        """.utf8)
        fakeNetworkService.data = data
        
        let acronymService = AcronymServiceImpl(networkService: fakeNetworkService)
        var acronyms = [AcronymDetails]()
        acronymService.loadAcronymTranscript(acronym: "MMMMMMMM") { result in
            switch result {
            case .success(let acronymsResult):
                acronyms = acronymsResult
            case .failure(let error):
                print(error)
            }
        }
        XCTAssertEqual(acronyms.count, 0)
    }
    
    func testAcronymService_networkError() throws {
        fakeNetworkService.error = NSError("Connection error")
        
        let acronymService = AcronymServiceImpl(networkService: fakeNetworkService)
        var error: Error? = nil
        acronymService.loadAcronymTranscript(acronym: "") { result in
            switch result {
            case .failure(let  resultError):
                error = resultError
            default: break
            }
        }
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, "Connection error")
    }
}
