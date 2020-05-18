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
        state = gravity(state)

        state = move(state)
        state = walk(state)
        state = jump(state)
        state = physics(state)

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

func physics(_ state: RootState) -> RootState {
    var state = state
    state.y = max(0, state.y + state.jump.velocity.y)
    return state
}

/// Change the velocity at which `physics` will pull the character towards the ground.
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

extension Jump {
    fileprivate var velocity: Velocity {
        switch self {
        case .resting: return Velocity.zero
        case .airborne(let velocity): return Velocity(x: 0, y: velocity)
        }
    }
}

func move(_ state: RootState) -> RootState {
    var state = state
    state.walkDirection = {
        if state.keysHeld.contains(.left) {
            return .left
        } else if state.keysHeld.contains(.right) {
            return .right
        } else {
            return .none
        }
    }()
    return state
}

func walk(_ state: RootState) -> RootState {
    var state = state
    state.x += state.walkDirection.velocity.x
    return state
}

extension WalkDirection {
    fileprivate var velocity: Velocity {
        switch self {
        case .none:  return Velocity(x: 0, y: 0)
        case .left:  return Velocity(x: -walkingSpeed, y: 0)
        case .right: return Velocity(x: +walkingSpeed, y: 0)
        }
    }
}
