//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit
import State

/// Global store to dispatch events and subscribe to states.
let store = State.store()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let keyInputHandler = KeyInputHandler()

    override var next: UIResponder? {
        return keyInputHandler
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
