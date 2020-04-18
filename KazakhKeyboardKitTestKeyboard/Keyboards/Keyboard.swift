//
//  KazKeyboard.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import KeyboardKit

/**
 This protocol is used by the demo application keyboards and
 provides shared functionality.
 
 The demo keyboards are for demo purposes, so they lack some
 functionality, like adapting to other languages, device types etc.
 */
protocol KazKeyboard {}

extension KazKeyboard {
    
    static func bottomActions(leftmost: KeyboardAction, for vc: KeyboardViewController) -> KeyboardActionRow {
        let actions = [leftmost, switchAction(for: vc), .space, .newLine]
        return actions
    }
    
    static func bottomActionsCustom(leftmost: KeyboardAction, for vc: KeyboardViewController) -> KeyboardActionRow {
        let actions = [leftmost, .space, .newLine]
        return actions
    }
}

private extension KazKeyboard {
    
    static func switchAction(for vc: KeyboardViewController) -> KeyboardAction {
        let needsSwitch = vc.needsInputModeSwitchKey
        return needsSwitch ? .switchKeyboard : .switchToKeyboard(.emojis)
    }
}
