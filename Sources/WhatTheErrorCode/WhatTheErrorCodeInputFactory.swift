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
        let rawValue = rawValue.lowercased()
        let pattern = #"domain=([^\s]+).*code=(-?\d+)"#
        let regex = try! NSRegularExpression(pattern: pattern)

        guard let result = regex.firstMatch(in: rawValue, options: [], range: NSRange(location: 0, length: rawValue.count)) else { return nil }

        guard
            let domainRange = Range(result.range(at: 1), in: rawValue),
            let errorCodeRange = Range(result.range(at: 2), in: rawValue) else {
            return nil
        }

        let domain = String(rawValue[domainRange])
        guard let errorCode = Int(rawValue[errorCodeRange]) else { return nil }

        return WhatTheErrorCodeInput(code: errorCode, domain: domain)
    }
}
