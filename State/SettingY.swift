//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

/// Action that directly affects the Y-coordinate of the player. For the `Walking` action, it was
/// pretty simple to change the X-coordinate on every tick by using a walk offset. But `Jumping`
/// is a stateful animation; `Jumping` controls the animation phase, and this is the unfortunate
/// named _effect_ of the animation.
struct SettingY: ReSwift.Action {
    let y: Double
    init(_ y: Double) {
        self.y = y
    }
}

extension SettingY: StateApplicable {
    func applied(to state: RootState) -> RootState {
        var state = state
        state.y = y
        return state
    }
}
