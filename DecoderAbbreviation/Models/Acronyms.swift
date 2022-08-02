//
//  Abbreviation.swift
//  DecoderAbbreviation
//
//  Created by Tatiana Ampilogova on 8/1/22.
//

import Foundation

struct Acronym: Codable {
    var details: [AcronymDetails]
    
    enum CodingKeys: String, CodingKey {
        case details = "lfs"
    }
}
struct AcronymDetails: Codable {
    var fullForms: String
    var frequently: Int
    var date: Int
    var variations: [VariationForms]
    
    enum CodingKeys: String, CodingKey {
        case fullForms = "lf"
        case frequently = "freq"
        case date = "since"
        case variations = "vars"
    }
}

struct VariationForms: Codable {
    var fullForms: String
    var frequently: Int
    var date: Int
    
    enum CodingKeys: String, CodingKey {
        case fullForms = "lf"
        case frequently = "freq"
        case date = "since"
        
    }
}
