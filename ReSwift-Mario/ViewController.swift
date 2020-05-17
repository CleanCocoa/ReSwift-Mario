//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit
import State
import ReSwift

class ViewController: UIViewController {
    let fpsViewController = FPSViewController()

    let playerViewController = PlayerViewController()
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
        addFPS()

        // Subscribing fires an update for the initial state immediately, so make sure all
        // positional properties are set up already.
        store.subscribe(playerViewController) {
            $0.select(PlayerViewController.PlayerPosition.init(rootState:))
                .skipRepeats() }
        store.subscribe(fpsViewController) { $0.select { $0.fps }.skipRepeats() }
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
        add(childViewController: playerViewController)
        playerViewController.constrainPlayer(toGround: ground)
    }

    private func addFPS() {
        add(childViewController: fpsViewController)
    }

    // MARK: - User Input

    private var heldKeys: Set<Key> = []

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        // If this is the screen, tapping next to the player image equals pressing the direction key:
        //
        //    |        [Player]        |
        //
        //   left ^^^^           ^^^^ right
        if playerViewController.view.frame.minX - touch.location(in: self.view).x > 0 {
            heldKeys.insert(.left)
            store.dispatch(HoldingKey(key: .left))
        }
        if touch.location(in: self.view).x - playerViewController.view.frame.maxX > 0 {
            heldKeys.insert(.right)
            store.dispatch(HoldingKey(key: .right))
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        heldKeys.map(RaisingKey.init(key:)).forEach(store.dispatch)
        heldKeys = []
    }
}
