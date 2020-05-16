//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import XCTest
@testable import State

class ReduceWalkingTests: XCTestCase {
    func testWalkingLeft() {
        let result = Walking.left.applied(to: RootState(x: 123, y: 456))
        XCTAssertEqual(result, RootState(x: 123 - 2, y: 456))
    }

    func testWalkingRight() {
        let result = Walking.right.applied(to: RootState(x: 987, y: 654))
        XCTAssertEqual(result, RootState(x: 987 + 2, y: 654))
    }
}
