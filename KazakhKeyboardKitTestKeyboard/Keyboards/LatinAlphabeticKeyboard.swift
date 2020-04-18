//
//  AlphabeticKeyboard.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import KeyboardKit

struct LatinAlphabeticKeyboard: KazKeyboard {
    
    init(uppercased: Bool, in viewController: KeyboardViewController) {
        actions = LatinAlphabeticKeyboard.actions(
            uppercased: uppercased,
            in: viewController)
    }

    let actions: KeyboardActionRows
}

private extension LatinAlphabeticKeyboard {
    
    static func actions(
        uppercased: Bool,
        in viewController: KeyboardViewController) -> KeyboardActionRows {
        KeyboardActionRows
            .from(characters(uppercased: uppercased))
            .addingSideActions(uppercased: uppercased)
            .appending(bottomActions(leftmost: switchAction, for: viewController))
    }
    
    static let characters: [[String]] = [
        ["á", "ı", "ń", "ǵ", "ú", "ý", "ó", "sh", "ch"],
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]
    
    static func characters(uppercased: Bool) -> [[String]] {
        uppercased ? characters.uppercased() : characters
    }
    
    static var switchAction: KeyboardAction {
        .switchToKeyboard(.numeric)
    }
}

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func addingSideActions(uppercased: Bool) -> [Iterator.Element] {
        var result = map { $0 }
        result[3].insert(uppercased ? .shiftDown : .shift, at: 0)
        result[3].insert(.none, at: 1)
        result[3].append(.none)
        result[3].append(.backspace)
        return result
    }
    
    
}
