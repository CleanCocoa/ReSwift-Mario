//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import XCTest
@testable import State

class ReduceHoldingKeyTests: XCTestCase {
    func testHoldingKey_EmptyState_AddsKey() {
        let result = HoldingKey(key: .left).applied(to: RootState(keysHeld: []))
        XCTAssertEqual(result, RootState(keysHeld: [.left]))
    }

    func testHoldingKey_OtherKeyAlreadyHeld_AddsKey() {
        let result = HoldingKey(key: .right).applied(to: RootState(keysHeld: [.left]))
        XCTAssertEqual(result, RootState(keysHeld: [.left, .right]))
    }

    func testHoldingKey_KeyAlreadyHeld_StateIsUnchanged() {
        let result = HoldingKey(key: .left).applied(to: RootState(keysHeld: [.left]))
        XCTAssertEqual(result, RootState(keysHeld: [.left]))
    }
}
