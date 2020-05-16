//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

/// Notifies the world/state of a tick event, used to limit the actual FPS.
/// This action is internal because we don't want the application to interfere.
internal struct Tick: ReSwift.Action {
    init() {}
}

extension Tick: StateApplicable {
    func applied(to state: RootState) -> RootState {
        var state = state
        state.ticksCounted += 1
        return state
    }
}
