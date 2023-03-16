import Foundation

public struct CocoaErrorDescription: Codable, Equatable, Identifiable {
    public var id: String { key + "_\(code)" }
    public let code: Int
    public let key: String
    public let description: String
}

struct CocoaErrorDomain: Codable {
    let key: String
    let errors: [CocoaErrorDescription]
}

public struct WhatTheErrorCode {

    static var errorDomains: [CocoaErrorDomain] = {
        guard
            let jsonURL = Bundle.module.url(forResource: "errors", withExtension: "json"),
            let jsonData = try? Data(contentsOf: jsonURL),
            let errorDomains = try? JSONDecoder().decode([CocoaErrorDomain].self, from: jsonData)
        else {
            return []
        }
        return errorDomains
    }()

    public static func description(for input: String) -> CocoaErrorDescription? {
        guard let input = WhatTheErrorCodeInputFactory(rawValue: input).make() else {
            return nil
        }
        print("Input is \(input)")

        return errorDomains.error(for: input)
    }
}

extension [CocoaErrorDomain] {
    func error(for input: WhatTheErrorCodeInput) -> CocoaErrorDescription? {
        if let domain = input.domain {
            return first(where: { $0.key.lowercased() == domain.lowercased() })?
                .errors
                .first(where: { $0.code == input.code })
        } else {
            return flatMap(\.errors)
                .first(where: { $0.code == input.code })
        }
    }
}
