//
//  SymbolicKeyboard.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import KeyboardKit


struct SymbolicKeyboard: KazKeyboard {
    
    init(in viewController: KeyboardViewController) {
        actions = type(of: self).actions(in: viewController)
    }
    
    let actions: KeyboardActionRows
}

private extension SymbolicKeyboard {
    
    static func actions(in viewController: KeyboardViewController) -> KeyboardActionRows {
        KeyboardActionRows
            .from(characters)
            .addingSideActions()
            .appending(bottomActions(leftmost: switchAction, for: viewController))
    }
    
    static var characters: [[String]] = [
        ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
        ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"],
        [".", ",", "?", "!", "´"]
    ]
    
    static var switchAction: KeyboardAction {
        .switchToKeyboard(.alphabetic(uppercased: false))
    }
}

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func addingSideActions() -> [Iterator.Element] {
        var actions = map { $0 }
        actions[2].insert(.switchToKeyboard(.numeric), at: 0)
        actions[2].insert(.none, at: 1)
        actions[2].append(.none)
        actions[2].append(.backspace)
        return actions
    }
}
