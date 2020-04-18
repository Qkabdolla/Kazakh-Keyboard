//
//  CyrillicAlphabeticKeyboard.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/19/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import KeyboardKit


struct CyrillicAlphabeticKeyboard: KazKeyboard {
    
    init(uppercased: Bool, in viewController: KeyboardViewController) {
        actions = CyrillicAlphabeticKeyboard.actions(
            uppercased: uppercased,
            in: viewController)
    }

    let actions: KeyboardActionRows
}

private extension CyrillicAlphabeticKeyboard {
    
    static func actions(
        uppercased: Bool,
        in viewController: KeyboardViewController) -> KeyboardActionRows {
        KeyboardActionRows
            .from(characters(uppercased: uppercased))
            .addingSideActions(uppercased: uppercased)
            .appending(bottomActions(leftmost: switchAction, for: viewController))
    }
    
    static let characters: [[String]] = [
        ["ә", "і", "ң", "ғ", "ү", "ұ", "қ", "ө", "h"],
        ["й", "ц", "у", "к", "е", "н", "г", "ш", "щ", "з", "х"],
        ["ф", "ы", "в", "а", "п", "р", "о", "л", "д", "ж", "э"],
        ["я", "ч", "с", "м", "и", "т", "ь", "б", "ю"]
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
