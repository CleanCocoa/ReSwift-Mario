//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

let initialJumpVelocity: Double = 8.0
let gravity: Double = 0.3

/// `Jumping` changes the `State.jump` animation state. It does not affect the Y-coordinate
/// of the player. I decided to separate `Jumping` from `SettingY` to keep the application of
/// `Jumping.gravitate` symmetrical: this action only affects one state property, not two.
enum Jumping: ReSwift.Action {
    /// Transitions into the jump animation with the initial jump velocity.
    case start
    /// Step of the jump animation, applying gravity.
    case gravitate
    /// Transition out of the jump animation.
    case land
}

extension Jumping: StateApplicable {
    func applied(to state: RootState) -> RootState {
        var state = state
        switch (self, state.jump) {
        case (.start, _):
            state.jump = .airborne(velocity: initialJumpVelocity)

        case (.gravitate, .airborne(let velocity)):
            state.jump = .airborne(velocity: velocity - gravity)
            // One could consider setting `state.y += velocity` here. But from a reducer, there's
            // no way to dispatch the "ending animation" action. So instead of dispatching `.land`,
            // one would have to set `state.jump = .resting` at the end. That puts all the
            // business logic of jumping and landing into this reducer. It will work, but I prefer
            // the middleware as an animation processor and keeping the reducer dumb.
        case (.gravitate, _):
            // This would be an invalid combination
            break

        case (.land, _):
            state.jump = .resting
        }
        return state
    }
}

