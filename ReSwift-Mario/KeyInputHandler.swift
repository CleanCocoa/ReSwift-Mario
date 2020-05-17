//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit
import State

class KeyInputHandler: UIResponder {
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            switch press.type {
            case .upArrow:    keyDown(.jump)
            case .leftArrow:  keyDown(.left)
            case .rightArrow: keyDown(.right)
            default: super.pressesBegan(presses, with: event)
            }
        }
    }

    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            switch press.type {
            case .upArrow:    keyUp(.jump)
            case .leftArrow:  keyUp(.left)
            case .rightArrow: keyUp(.right)
            default: super.pressesEnded(presses, with: event)
            }
        }
    }

    func keyDown(_ key: Key) {
        store.dispatch(HoldingKey(key: key))
    }

    func keyUp(_ key: Key) {
        store.dispatch(RaisingKey(key: key))
    }
}
