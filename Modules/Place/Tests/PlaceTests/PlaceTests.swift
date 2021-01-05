import XCTest
@testable import Place

final class PlaceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Place().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
