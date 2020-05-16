//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit
import State
import ReSwift

let store = State.store()

class ViewController: UIViewController, ReSwift.StoreSubscriber {
    let player = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.blue
    }
    let background = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.init(red: 135.0/256, green: 206.0/256, blue: 235.0/256, alpha: 1.0)
    }
    let ground = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.green
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSky()
        addGround()
        addPlayer()

        // Subscribing fires an update for the initial state immediately, so make sure all
        // positional properties are set up already.
        store.subscribe(self) { $0.select { ($0.x, $0.y)  }}
    }

    private func addSky() {
        view.addSubview(background)
        background.constrainToFillSuperview()
    }

    private func addGround() {
        view.addSubview(ground)

        // Fill the screen horizontally ...
        ground.constrainToFillSuperviewHorizontally()

        // ... but take up only bottom 1/3 of the height to leave some space for the player.
        let yAxisConstraints = [
            ground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            ground.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        yAxisConstraints.forEach(activate)
    }

    private func addPlayer() {
        view.addSubview(player)

        let sizeAnchors = [
            player.heightAnchor.constraint(equalToConstant: 40),
            player.widthAnchor.constraint(equalToConstant: 40)
            ]
        sizeAnchors.forEach(activate)

        playerPositionConstraints = (
            x: player.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            y: player.bottomAnchor.constraint(equalTo: ground.topAnchor, constant: 0)
        )
        [playerPositionConstraints.x, playerPositionConstraints.y].forEach(activate)
    }

    var playerPositionConstraints: (x: NSLayoutConstraint, y: NSLayoutConstraint)!

    func newState(state position: (x: Double, y: Double)) {
        playerPositionConstraints.x.constant = CGFloat(position.x)
        playerPositionConstraints.y.constant = -CGFloat(position.y)
    }
}

private func activate(_ anchor: NSLayoutConstraint) {
    anchor.isActive = true
}

extension UIView {
    func constrainToFillSuperview() {
        constrainToFillSuperviewHorizontally()
        constrainToFillSuperviewVertically()
    }

    func constrainToFillSuperviewHorizontally() {
        guard let superview = self.superview else { preconditionFailure("superview has to be set first") }
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }

    func constrainToFillSuperviewVertically() {
        guard let superview = self.superview else { preconditionFailure("superview has to be set first") }
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }
}
