//
//  NSError.swift
//  DecoderAbbreviation
//
//  Created by Tatiana Ampilogova on 8/1/22.
//

import Foundation

extension NSError {
    
    convenience init(_ description: String) {
        self.init(domain: "Local domain", code: -1, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
