//
//  UIInputViewController+AutocompleteBugFixTimer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-18.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIInputViewController {
    
    @available(*, deprecated, message: "Do not use this. Instead, make the action handler refresh autocomplete as the user types.")
    func createAutocompleteBugFixTimer(
        withTickInterval tickInterval: TimeInterval = 1,
        reversalInterval: TimeInterval = 0.0001) -> AutocompleteBugFixTimer {
        AutocompleteBugFixTimer(
            viewController: self,
            tickInterval: tickInterval,
            reversalInterval: reversalInterval
        )
    }
}
