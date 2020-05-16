//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit
import ReSwift

class FPSViewController: UIViewController, ReSwift.StoreSubscriber {
    lazy var fpsLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize * 2)
        $0.textColor = UIColor.white
        $0.shadowColor = UIColor.black
        $0.shadowOffset = CGSize(width: 1, height: 1)
        $0.text = "FPS: ???"
    }

    override func loadView() {
        super.loadView()
        self.view = fpsLabel
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        if let newParent = parent {
            let positionaConstraints = [
                self.view.topAnchor.constraint(equalTo: newParent.view.safeAreaLayoutGuide.topAnchor),
                self.view.leadingAnchor.constraint(equalTo: newParent.view.leadingAnchor, constant: 4)
            ]
            positionaConstraints.forEach(activate)
        }
    }

    func newState(state fps: Double) {
        self.fpsLabel.text = String(format: "FPS: %.1f", fps)
    }
}
