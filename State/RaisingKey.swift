//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

public struct RaisingKey: ReSwift.Action {
    public let key: Key

    public init(key: Key) {
        self.key = key
    }
}

extension RaisingKey: StateApplicable {
    func applied(to state: RootState) -> RootState {
        var state = state
        state.keysHeld.remove(key)
        return state
    }
}
