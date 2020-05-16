//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

/// Dispatched internally every second to count the frames/ticks that have passed.
internal struct CountingFPS: ReSwift.Action {}

extension CountingFPS: StateApplicable {
    func applied(to state: RootState) -> RootState {
        var state = state
        state.fps = state.ticksCounted
        state.ticksCounted = 0
        return state
    }
}

