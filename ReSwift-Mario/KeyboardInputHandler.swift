//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit

class KeyboardInputHandler: UIResponder {
    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: UIKeyCommand.inputLeftArrow, modifierFlags: [], action: #selector(leftArrowKeyPressed)),
            UIKeyCommand(input: UIKeyCommand.inputRightArrow, modifierFlags: [], action: #selector(rightArrowKeyPressed))
        ]
    }

    @objc func leftArrowKeyPressed() {
        print("Left")
    }

    @objc func rightArrowKeyPressed() {
        print("Right")
    }
}
