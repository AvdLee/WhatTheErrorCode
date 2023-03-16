//
//  WhatTheErrorCodeInput.swift
//  
//
//  Created by Antoine van der Lee on 16/03/2023.
//

import Foundation

struct WhatTheErrorCodeInput {
    let code: Int
    let domain: String?
}

struct WhatTheErrorCodeInputFactory {
    let rawValue: String

    func make() -> WhatTheErrorCodeInput? {
        let rawValue = rawValue.lowercased()
        let pattern = #"(?:domain=([^\s]+)\s+)?code=(-?\d+)"#
        let regex = try! NSRegularExpression(pattern: pattern)

        guard let result = regex.firstMatch(in: rawValue, options: [], range: NSRange(location: 0, length: rawValue.count)) else {
            if let errorCode = Int(rawValue) {
                /// For code only inputs.
                return WhatTheErrorCodeInput(code: errorCode, domain: nil)
            }

            return nil
        }

        guard
            let errorCodeRange = Range(result.range(at: 2), in: rawValue),
            let errorCode = Int(rawValue[errorCodeRange])
        else {
            return nil
        }

        var domain: String?

        if let domainRange = Range(result.range(at: 1), in: rawValue) {
            domain = String(rawValue[domainRange])
        }

        return WhatTheErrorCodeInput(code: errorCode, domain: domain)
    }
}
