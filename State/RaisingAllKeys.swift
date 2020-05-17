//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

public struct RaisingAllKeys: ReSwift.Action {
    public init() {}
}

extension RaisingAllKeys: StateApplicable {
    func applied(to state: RootState) -> RootState {
        var state = state
        state.keysHeld = []
        return state
    }
}
