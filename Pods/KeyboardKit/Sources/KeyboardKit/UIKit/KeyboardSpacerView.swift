//
//  KeyboardSpacerView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-07.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This view can be used as a horizontal space in a button row.
 For instance, you can map the `.none` keyboard action to it,
 so that you can declare "spaces" in your action collections.
 */
open class KeyboardSpacerView: UIView, KeyboardButtonRowComponent {
    
    public convenience init(width: CGFloat) {
        self.init(frame: .zero)
        self.width = width
    }
    
    public var widthConstraint: NSLayoutConstraint?
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: width, height: size.height)
    }
}
