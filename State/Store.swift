//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

struct Velocity: AdditiveArithmetic {
    static var zero = Velocity(x: 0, y: 0)

    var x: Double
    var y: Double

    static func + (lhs: Velocity, rhs: Velocity) -> Velocity {
        return Velocity(x: lhs.x + rhs.x,
                        y: lhs.y + rhs.y)
    }

    static func - (lhs: Velocity, rhs: Velocity) -> Velocity {
        return Velocity(x: lhs.x - rhs.x,
                        y: lhs.y - rhs.y)
    }

    static func -= (lhs: inout Velocity, rhs: Velocity) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }

    static func += (lhs: inout Velocity, rhs: Velocity) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}

public enum Key: Hashable {
    case left, right, jump
}

/// Jump animation phases.
enum Jump: Equatable {
    case resting
    case airborne(velocity: Double)
}

/// Walk animation direction.
enum WalkDirection {
    case none
    case left, right
}

public struct RootState: ReSwift.StateType, Equatable {
    // MARK: Game state
    /// Counted frames; internally used as transient state.
    internal var ticksCounted = 0.0
    public var fps = 0.0

    // MARK: User controls
    public var keysHeld: Set<Key> = []

    // MARK: Player position
    public var x: Double = 100
    public var y: Double = 0

    // MARK: Animations
    internal var jump: Jump = .resting
    internal var walkDirection: WalkDirection = .none
}

public func store() -> ReSwift.Store<RootState> {
    return ReSwift.Store(
        reducer: { action, rootState in
            let state = rootState ?? RootState()
            guard let appliableAction = action as? StateApplicable else { return state }
            return appliableAction.applied(to: state)
        },
        state: RootState(),
        middleware: [
            // Internal housekeeping middleware for debugging
            loggingMiddleware, FPSCounterMiddleware
        ],
        automaticallySkipsRepeats: false)
}

/// This is used to make `ReSwift.Action`s apply temselves to the state. The usual approach
/// of using a free function like `reduce(action:state:)` works as well, but then folks
/// commonly use a giant switch-case. This protocol allows us to encapsulate this knowledge in
/// the action objects. You know, basic OOP polymorphism :)  In a purely functional language
/// with dumb data like Lisp/Scheme/Clojure, free functions would work best.
protocol StateApplicable {
    func applied(to state: RootState) -> RootState
}
