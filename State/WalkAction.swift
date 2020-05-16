//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import ReSwift

public enum Walking: ReSwift.Action {
    case left, right
}

extension Walking: StateApplicable {
    private var offset: Double {
        switch self {
        case .left:  return -2
        case .right: return +2
        }
    }
    
    func applied(to state: RootState) -> RootState {
        var state = state
        state.x += offset
        return state
    }
}
