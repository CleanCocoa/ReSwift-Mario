//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

let fpsLimit: Double = 60
private var tickTimer: Timer?
private var fpsTimer: Timer?

/// **Action generator** middleware that works with a timer to generate `Tick` actions according
/// to the `FPS` settings. Passes all actions through unaltered.
let FPSCounterMiddleware: Middleware<RootState> = { dispatch, getState in
    // This part of the middleware is called upon `ReSwift.Store` initialization.
    if fpsTimer == nil {
        fpsTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            dispatch(CountingFPS())
        }
    }

    if tickTimer == nil {
        tickTimer = Timer.scheduledTimer(withTimeInterval: 1.0 / fpsLimit, repeats: true) { timer in
            dispatch(Tick())
        }
    }

    return passthrough()
}

func passthrough() -> (@escaping DispatchFunction) -> DispatchFunction {
    return { next in
        return { action in
            next(action)
        }
    }
}
