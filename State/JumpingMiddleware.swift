//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

/// Animation processor to
/// - start jumping when the player is resting on the ground and the jump key is held,
/// - process jump animation steps while mid-air,
/// - land the player character when it touches the ground.
let jumpingMiddleware: Middleware<RootState> = { dispatch, getState in
    return { next in
        return { action in
            next(action)

            // Only move on frame tick to have a constant movement speed, bound to the FPS.
            guard action is Tick else { return }
            guard let state = getState() else { return }

            switch state.jump {
            case .resting:
                if state.keysHeld.contains(.jump) {
                    dispatch(Jumping.start)
                }
            case .airborne(let velocity):
                let newY = max(0, state.y + velocity)
                dispatch(SettingY(newY))
                if newY == 0 {
                    dispatch(Jumping.land)
                } else {
                    dispatch(Jumping.gravitate)
                }
            }
        }
    }
}
