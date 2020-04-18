//
//  KeyboardViewController+Setup.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func setupKeyboard() {
        setupKeyboard(for: view.bounds.size)
    }
    
    func setupKeyboard(for size: CGSize) {
        DispatchQueue.main.async {
            self.setupKeyboardAsync(for: size)
        }
    }
    
    func setupKeyboardAsync(for size: CGSize) {
        keyboardStackView.removeAllArrangedSubviews()
        switch keyboardType {
        case .alphabetic(let uppercased): setupAlphabeticKeyboard(uppercased: uppercased)
        case .emojis: setupEmojiKeyboard(for: size)
        case .numeric: setupNumericKeyboard()
        case .symbolic: setupSymbolicKeyboard()
        default: return
        }
    }
    
    func setupAlphabeticKeyboard(uppercased: Bool = false) {
        switch keyType {
        case .latin:
            let keyboard = LatinAlphabeticKeyboard(uppercased: uppercased, in: self)
            let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
            keyboardStackView.addArrangedSubviews(rows)
        case .cyrillic:
            let keyboard = CyrillicAlphabeticKeyboard(uppercased: uppercased, in: self)
            let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
            keyboardStackView.addArrangedSubviews(rows)
        }
    }
    
    func setupEmojiKeyboard(for size: CGSize) {
        let keyboard = EmojiKeyboard(in: self)
        let isLandscape = size.width > 400
        let rowsPerPage = isLandscape ? 4 : 5
        let buttonsPerRow = isLandscape ? 10 : 8
        let config = KeyboardButtonRowCollectionView.Configuration(rowHeight: 40, rowsPerPage: rowsPerPage, buttonsPerRow: buttonsPerRow)
        let view = KeyboardButtonRowCollectionView(actions: keyboard.actions, configuration: config) { [unowned self] in return self.button(for: $0) }
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
    }
    
    func setupNumericKeyboard() {
        let keyboard = NumericKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
    
    func setupSymbolicKeyboard() {
        let keyboard = SymbolicKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
}
