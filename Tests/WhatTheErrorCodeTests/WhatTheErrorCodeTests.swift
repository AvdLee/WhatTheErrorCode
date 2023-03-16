import XCTest
@testable import WhatTheErrorCode

final class WhatTheErrorCodeTests: XCTestCase {
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