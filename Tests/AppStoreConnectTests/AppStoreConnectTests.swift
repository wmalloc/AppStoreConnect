import XCTest
@testable import AppStoreConnect

final class AppStoreConnectTests: XCTestCase {
    func testStatusCodes() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AppStoreConnect().validStatusCodes, 200..<300)
    }
}
