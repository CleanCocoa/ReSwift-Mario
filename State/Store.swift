//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

public struct RootState: ReSwift.StateType {}

public func store() -> ReSwift.Store<RootState> {
    return ReSwift.Store(
        reducer: rootReducer,
        state: RootState(),
        middleware: [],
        automaticallySkipsRepeats: false)
}

func rootReducer(action: Action, state: RootState?) -> RootState {
    return state ?? RootState()
}
