//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

let loggingMiddleware: Middleware<RootState> = { dispatch, getState in
    return { next in
        return { action in
            print(action)
            next(action)
        }
    }
}
