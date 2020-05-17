//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import XCTest
@testable import State

class ReduceRaisingKeyTests: XCTestCase {
    func testRaisingKey_EmptyState_StateIsUnchanged() {
        let result = RaisingKey(key: .right).applied(to: RootState(keysHeld: []))
        XCTAssertEqual(result, RootState(keysHeld: []))
    }

    func testRaisingKey_OtherKeyHeld_StateIsUnchanged() {
        let result = RaisingKey(key: .right).applied(to: RootState(keysHeld: [.left]))
        XCTAssertEqual(result, RootState(keysHeld: [.left]))
    }

    func testRaisingKey_OnlyThatKeyHeld_ClearsKeysHeld() {
        let result = RaisingKey(key: .right).applied(to: RootState(keysHeld: [.right]))
        XCTAssertEqual(result, RootState(keysHeld: []))
    }

    func testRaisingKey_KeyAndAnotherIsHeld_RemovesRaiedKey() {
        let result = RaisingKey(key: .left).applied(to: RootState(keysHeld: [.jump]))
        XCTAssertEqual(result, RootState(keysHeld: [.jump]))
    }
}

class ReduceRaisingAllKeysTests: XCTestCase {
    func testRaisingAllKeys_NoKeysHeld_StateIsUnchanged() {
        let result = RaisingAllKeys().applied(to: RootState(keysHeld: []))
        XCTAssertEqual(result, RootState(keysHeld: []))
    }

    func testRaisingAllKeys_SomeKeysHeld_StateIsUnchanged() {
        let result = RaisingAllKeys().applied(to: RootState(keysHeld: [.jump, .left]))
        XCTAssertEqual(result, RootState(keysHeld: []))
    }
}
