//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import XCTest
@testable import State

class ReduceWalkingTests: XCTestCase {
    func testWalkingLeft() {
        let result = reduce(Walking.left, state: RootState(x: 123, y: 456))
        XCTAssertEqual(result, RootState(x: 123 - 2, y: 456))
    }

    func testWalkingRight() {
        let result = reduce(Walking.right, state: RootState(x: 987, y: 654))
        XCTAssertEqual(result, RootState(x: 987 + 2, y: 654))
    }
}
