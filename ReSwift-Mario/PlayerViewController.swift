//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit
import ReSwift
import State

class PlayerViewController: UIViewController, ReSwift.StoreSubscriber {
    // MARK: Model

    var playerPositionConstraints: (x: NSLayoutConstraint, y: NSLayoutConstraint)!

    // MARK: View

    override func loadView() {
        super.loadView()

        self.view = UIView().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = UIColor.blue
        }

        let sizeAnchors = [
            view.heightAnchor.constraint(equalToConstant: 40),
            view.widthAnchor.constraint(equalToConstant: 40)
        ]
        sizeAnchors.forEach(activate)
    }

    func constrainPlayer(toGround ground: UIView) {
        guard self.playerPositionConstraints == nil else {
            preconditionFailure("\(#function) can only be called once")
        }

        guard let superview = view.superview else {
            preconditionFailure("Install PlayerViewController.view into view hierarchy before adding constraints")
        }

        self.playerPositionConstraints = (
            x: view.centerXAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0),
            y: view.bottomAnchor.constraint(equalTo: ground.topAnchor, constant: 0)
        )
        [playerPositionConstraints.x, playerPositionConstraints.y].forEach(activate)
    }

    // MARK: Updates

    struct PlayerPosition: Equatable {
        let x: Double
        let y: Double
    }

    func newState(state position: PlayerPosition) {
        precondition(playerPositionConstraints != nil, "Install PlayerViewController into view hierarchy first using `constrainPlayer(toGround:)`.")

        playerPositionConstraints.x.constant = CGFloat(position.x)
        playerPositionConstraints.y.constant = -CGFloat(position.y)
    }
}

extension PlayerViewController.PlayerPosition {
    init(rootState: RootState) {
        self.init(
            x: rootState.x,
            y: rootState.y)
    }
}
