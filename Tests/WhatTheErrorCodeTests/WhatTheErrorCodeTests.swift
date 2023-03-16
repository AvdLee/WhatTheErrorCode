import XCTest
@testable import WhatTheErrorCode

final class WhatTheErrorCodeTests: XCTestCase {
    func testCodeWithKeyOnlyInput() throws {
        let expectedError = CocoaErrorDescription(
            code: 1590,
            key: "NSValidationRelationshipExceedsMaximumCountError",
            description: "bounded, to-many relationship with too many destination objects"
        )
        XCTAssertEqual(
            WhatTheErrorCode.description(for: "code=1590"),
            expectedError
        )
    }

    func testCodeOnlyInput() throws {
        let expectedError = CocoaErrorDescription(
            code: 1590,
            key: "NSValidationRelationshipExceedsMaximumCountError",
            description: "bounded, to-many relationship with too many destination objects"
        )
        XCTAssertEqual(
            WhatTheErrorCode.description(for: "1590"),
            expectedError
        )
    }

    func testCoreDataExample() throws {
        let expectedError = CocoaErrorDescription(
            code: 1590,
            key: "NSValidationRelationshipExceedsMaximumCountError",
            description: "bounded, to-many relationship with too many destination objects"
        )
        XCTAssertEqual(
            WhatTheErrorCode.description(for: "Domain=NSCocoaErrorDomain Code=1590 \"The operation couldn't be completed. (Cocoa error 1590.)"),
            expectedError
        )
    }

    func testLowercaseExample() throws {
        let expectedError = CocoaErrorDescription(
            code: 1590,
            key: "NSValidationRelationshipExceedsMaximumCountError",
            description: "bounded, to-many relationship with too many destination objects"
        )
        XCTAssertEqual(
            WhatTheErrorCode.description(for: "domain=nscocoaerrordomain code=1590 \"The operation couldn't be completed. (Cocoa error 1590.)"),
            expectedError
        )
    }

    func testNSURLErrorDomainExample() throws {
        let expectedError = CocoaErrorDescription(
            code: -1020,
            key: "NSURLErrorDataNotAllowed",
            description: "The cellular network disallowed a connection."
        )
        XCTAssertEqual(
            WhatTheErrorCode.description(for: """
            Error Domain=NSURLErrorDomain Code=-1020 "De momento, não é permitida a transmissão de dados." UserInfo={_kCFStreamErrorCodeKey=50
            """),
            expectedError
        )
    }

    func testValidateJSON() throws {
        let errorDomains = WhatTheErrorCode.errorDomains
        XCTAssertFalse(errorDomains.isEmpty)

        let uniqueErrorDomains = Set(errorDomains.map(\.key))
        XCTAssertEqual(uniqueErrorDomains.count, errorDomains.count, "There are duplicate domains")

        errorDomains.forEach { errorDomain in
            let uniqueErrorCodes = Set(errorDomain.errors.map(\.code))
            XCTAssertEqual(uniqueErrorCodes.count, errorDomain.errors.count, "There are duplicate codes")
        }
    }
}
