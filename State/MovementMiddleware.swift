//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

let movementMiddleware: Middleware<RootState> = { dispatch, getState in
    return { next in
        return { action in
            next(action)

            // Only move once per tick to have a constant movement speed, bound to the FPS.
            guard action is Tick else { return }
            guard let keysHeld = getState()?.keysHeld else { return }

            if keysHeld.contains(.left) {
                dispatch(Walking.left)
            } else if keysHeld.contains(.right) {
                dispatch(Walking.right)
            }
        }
    }
}

