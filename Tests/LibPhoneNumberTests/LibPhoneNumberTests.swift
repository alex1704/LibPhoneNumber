import XCTest
@testable import LibPhoneNumber

final class LibPhoneNumberTests: XCTestCase {
    func testPhoneNumberParsing() throws {
        // given
        let libPhoneNumber = try XCTUnwrap(LibPhoneNumber())

        // when
        let nationalNumber = 631112233
        let countryCode = 380
        let invalidNumber = "+\(countryCode)"
        let validNumber = "+\(countryCode)\(nationalNumber)"

        // then
        XCTAssertThrowsError(try libPhoneNumber.parsePhoneNumber(invalidNumber))
        let phoneNumber = try XCTUnwrap(try libPhoneNumber.parsePhoneNumber(validNumber))
        XCTAssert(phoneNumber.nationalNumber == nationalNumber)
        XCTAssert(phoneNumber.countryCode == countryCode)
        XCTAssert(phoneNumber.rawInput == validNumber)

    }

    func testRegionCodeExtraction() throws {
        // given
        let libPhoneNumber = try XCTUnwrap(LibPhoneNumber())

        // when
        let codes = [("+380997770302", "UA"), ("+81342130500", "JP"),
                     ("+14086065775", "US"), ("+441212242100", "GB")]

        // then
        for code in codes {
            let extracted = try XCTUnwrap(libPhoneNumber.regionCodeForPhoneNumber(code.0))
            XCTAssert(extracted == code.1, "\(extracted) != \(code.1)")
        }
    }

    func testExamplePhoneNumber() throws {
        // given
        let libPhoneNumber = try XCTUnwrap(LibPhoneNumber())

        // when
        let regions = ["UA", "JP", "US", "GB"]

        // then
        for region in regions {
            _ = try XCTUnwrap(try libPhoneNumber.examplePhoneNumber(region: region))
        }

        for region in regions {
            _ = try XCTUnwrap(try libPhoneNumber.examplePhoneNumber(region: region, type: .mobile))
        }
    }

    func testPhoneNumberValidity() throws {
        // given
        let libPhoneNumber = try XCTUnwrap(LibPhoneNumber())

        // when
        let validNumber = "+380631112233"
        let invalidNumber1 = "+38063111223"
        let invalidNumber2 = "+3806311122331"

        // then
        XCTAssert(try XCTUnwrap(try libPhoneNumber.isValidPhoneNumber(validNumber, region: "UA")))
        XCTAssertFalse(try XCTUnwrap(try libPhoneNumber.isValidPhoneNumber(validNumber, region: "US")))

        XCTAssertFalse(try XCTUnwrap(try libPhoneNumber.isValidPhoneNumber(invalidNumber1)))
        XCTAssertFalse(try XCTUnwrap(try libPhoneNumber.isValidPhoneNumber(invalidNumber2)))
        XCTAssertFalse(try XCTUnwrap(try libPhoneNumber.isValidPhoneNumber(invalidNumber1, region: "US")))
        XCTAssertFalse(try XCTUnwrap(try libPhoneNumber.isValidPhoneNumber(invalidNumber2, region: "US")))
    }

    func testPhoneNumberFormat() throws {
        // given
        let libPhoneNumber = try XCTUnwrap(LibPhoneNumber())

        // when
        let validNumber = "+380631112233"
        let invalidNumber = "380631112233"

        // then
        XCTAssert(!(try XCTUnwrap(try libPhoneNumber.formatPhoneNumber(validNumber))).isEmpty)
        XCTAssert(try libPhoneNumber.formatPhoneNumber(invalidNumber) == nil)
    }
}
