//
//  WhatTheErrorCodeInput.swift
//  
//
//  Created by Antoine van der Lee on 16/03/2023.
//

import Foundation

struct WhatTheErrorCodeInput {
    let code: Int
    let domain: String
}

struct WhatTheErrorCodeInputFactory {
    let rawValue: String

    func make() -> WhatTheErrorCodeInput? {
        let regex = try! NSRegularExpression(pattern: "Domain=(\\w+) Code=(\\d+)")
        guard let match = regex.firstMatch(in: rawValue, range: NSRange(rawValue.startIndex..., in: rawValue)) else {
            return nil
        }

        let domainRange = Range(match.range(at: 1), in: rawValue)!
        let codeRange = Range(match.range(at: 2), in: rawValue)!
        let domain = String(rawValue[domainRange])

        guard let code = Int(rawValue[codeRange]) else {
            return nil
        }

        return WhatTheErrorCodeInput(code: code, domain: domain)
    }
}
