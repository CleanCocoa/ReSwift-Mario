//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

let initialJumpVelocity: Double = 8.0
let gravity: Double = 0.3
let walkingSpeed: Double = 2

/// Notifies the world/state of a tick event, used to limit the actual FPS.
/// This action is internal because we don't want the UI or user to interfere.
///
/// All animations are performed in concert with `Tick`.
internal struct Tick: ReSwift.Action {
    init() {}
}

extension Tick: StateApplicable {
    func applied(to state: RootState) -> RootState {
        var state = state
        state.ticksCounted += 1

        // The order of the jump phase reducers is important: you don't want `gravity` to stop the
        // jump right after it has started, but before the Y-coordinate was affected.
        state = jump(state)
        state = physics(state)
        state = gravity(state)

        state = walk(state)

        return state
    }
}

/// Start the jump, if possible. (That is, if not already mid-air and the jump command was given.)
func jump(_ state: RootState) -> RootState {
    guard case .resting = state.jump else { return state }
    guard state.keysHeld.contains(.jump) else { return state }
    var state = state
    state.jump = .airborne(velocity: initialJumpVelocity)
    return state
}

/// Change the Y-coordinate in mid-air according to current velocity.
func physics(_ state: RootState) -> RootState {
    guard case .airborne(let velocity) = state.jump else { return state }
    var state = state
    state.y = max(0, state.y + velocity)
    return state
}

/// Change the velocity at which `physics` will move the character.
func gravity(_ state:  RootState) -> RootState {
    guard case .airborne(let velocity) = state.jump else { return state }
    var state = state
    state.jump = {
        // Decelerate upward movement/accelerate downward movement while above ground;
        // stop jumping animation when hitting the ground.
        if state.y > 0 {
            return .airborne(velocity: velocity - gravity)
        } else {
            return .resting
        }
    }()
    return state
}

func walk(_ state: RootState) -> RootState {
    let offset: Double = {
        if state.keysHeld.contains(.left) {
            return -walkingSpeed
        } else if state.keysHeld.contains(.right) {
            return +walkingSpeed
        } else {
            return 0
        }
    }()
    var state = state
    state.x += offset
    return state
}
