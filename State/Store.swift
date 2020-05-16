//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

public struct RootState: ReSwift.StateType, Equatable {
    public var x: Double = 100
    public var y: Double = 0
}

public func store() -> ReSwift.Store<RootState> {
    return ReSwift.Store(
        reducer: reduce(action:rootState:),
        state: RootState(),
        middleware: [loggingMiddleware],
        automaticallySkipsRepeats: false)
}

func reduce(action: Action, rootState: RootState?) -> RootState {
    var state = rootState ?? RootState()

    switch action {
    case let walking as Walking:
        state = reduce(walking, state: state)

    default:
        // Unrecognized/unhandled action
        break
    }

    return state
}
