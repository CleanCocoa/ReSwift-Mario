//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import XCTest
@testable import State

class ReduceWalkingTests: XCTestCase {
    func testWalkingLeft() {
        let result = walk(RootState(keysHeld: [.left], x: 123))
        XCTAssertEqual(result, RootState(keysHeld: [.left], x: 123 - 2))
    }

    func testWalkingRight() {
        let result = walk(RootState(keysHeld: [.right], x: 987))
        XCTAssertEqual(result, RootState(keysHeld: [.right], x: 987 + 2))
    }
}
