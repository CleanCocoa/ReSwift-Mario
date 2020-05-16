//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let keyboardInputHandler = KeyboardInputHandler()

    override var next: UIResponder? {
        return keyboardInputHandler
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
