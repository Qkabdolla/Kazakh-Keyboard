//
//  UIView+ActionTapGesture.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2017-12-12.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//
//  Reference: https://medium.com/@sdrzn/adding-gesture-recognizers-with-closures-instead-of-selectors-9fb3e09a8f0b
//

import UIKit

public extension UIView {
    
    typealias TapAction = () -> Void
    
    /**
     Add a tap gesture recognizer to the view.
    */
    func addTapAction(numberOfTapsRequired: Int = 1, action: @escaping TapAction) {
        tapAction = action
        isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAction))
        recognizer.numberOfTapsRequired = numberOfTapsRequired
        addGestureRecognizer(recognizer)
    }

    /**
     Remove all repeating gesture recognizers from the view.
    */
    func removeTapAction() {
        gestureRecognizers?
            .filter { $0 is UITapGestureRecognizer }
            .forEach { removeGestureRecognizer($0) }
    }
}

private extension UIView {
    
    struct Key { static var id = "tapAction" }
    
    var tapAction: TapAction? {
        get {
            objc_getAssociatedObject(self, &Key.id) as? TapAction
        }
        set {
            guard let value = newValue else { return }
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
            objc_setAssociatedObject(self, &Key.id, value, policy)
        }
    }

    @objc func handleTapAction(sender: UITapGestureRecognizer) {
        tapAction?()
    }
}
