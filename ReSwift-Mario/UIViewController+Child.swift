//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit

extension UIViewController {
    func add(childViewController: UIViewController) {
        self.addChild(childViewController)
        self.view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }

    func removeFromParentViewController() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
