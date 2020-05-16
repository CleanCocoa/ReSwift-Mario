//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

let loggingMiddleware: Middleware<RootState> = { dispatch, getState in
    return { next in
        return { action in
            // Ignore FPS ticks to not spam the log with 60 messages per second.
            if !(action is Tick) {
                print(action)
            }
            next(action)
        }
    }
}
