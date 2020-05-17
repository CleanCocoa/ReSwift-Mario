//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

/// Marks a key as pressed or held. Use `RaisingKey` to remove it from the pressed keys list.
public struct HoldingKey: ReSwift.Action {
    public let key: Key

    public init(key: Key) {
        self.key = key
    }
}

extension HoldingKey: StateApplicable {
    func applied(to state: RootState) -> RootState {
        var state = state
        state.keysHeld.insert(key)
        return state
    }
}
