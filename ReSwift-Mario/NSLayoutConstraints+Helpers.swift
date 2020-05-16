//  Copyright © 2020 Christian Tietze. All rights reserved. Distributed under the MIT License.

import UIKit

func activate(_ anchor: NSLayoutConstraint) {
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
