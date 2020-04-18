//
//  KazButton.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

/*
 
 Этот класс рисует вид кнопки клавиатуры
 как тот, который используется в системной клавиатуре iOS. Файл также
 содержит набор расширений для `KeyboardAction`, которые только
 относится к этому типу кнопки.
 
 */

import UIKit
import KeyboardKit

class KazButton: KeyboardButtonView {
    
    @IBOutlet weak var buttonView: UIView? {
        didSet { buttonView?.layer.cornerRadius = 7 }
    }
    
    @IBOutlet weak var image: UIImageView?
    
    @IBOutlet weak var textLabel: UILabel? {
        didSet { textLabel?.text = "" }
    }
    
    public func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController, distribution: UIStackView.Distribution = .fillEqually) {
        super.setup(with: action, in: viewController)
        backgroundColor = .clearInteractable
        buttonView?.backgroundColor = action.buttonColor(for: viewController)
        DispatchQueue.main.async { self.image?.image = action.buttonImage }
        textLabel?.font = action.buttonFont
        textLabel?.text = action.buttonText
        textLabel?.textColor = action.tintColor(in: viewController)
        buttonView?.tintColor = action.tintColor(in: viewController)
        width = action.buttonWidth(for: distribution)
        applyShadow(.standardButtonShadow)
    }
}


// MARK: - Private button-specific KeyboardAction Extensions

private extension KeyboardAction {
    
    func buttonColor(for viewController: KeyboardInputViewController) -> UIColor {
        let dark = useDarkAppearance(in: viewController)
        let asset = useDarkButton
            ? (dark ? Asset.Colors.darkSystemButton : Asset.Colors.lightSystemButton)
            : (dark ? Asset.Colors.darkButton : Asset.Colors.lightButton)
        return asset.color
    }
    
    var buttonFont: UIFont {
        return .preferredFont(forTextStyle: buttonFontStyle)
    }
    
    var buttonFontStyle: UIFont.TextStyle {
        switch self {
        case .character: return .title2
        case .switchToKeyboard(.emojis): return .title1
        default: return .body
        }
    }
    
    var buttonImage: UIImage? {
        switch self {
        case .image(_, let imageName, _): return UIImage(named: imageName)
        case .switchKeyboard: return Asset.Images.Buttons.switchKeyboard.image
        default: return nil
        }
    }
    
    var buttonText: String? {
        switch self {
        case .backspace: return "⌫"
        case .character(let text): return text
        case .newLine: return "return"
        case .shift, .shiftDown: return "⇧"
        case .space: return "kk-en"
        case .switchToKeyboard(let type): return buttonText(for: type)
        default: return nil
        }
    }
    
    func buttonText(for keyboardType: KeyboardType) -> String {
        switch keyboardType {
        case .alphabetic: return "ABC"
        case .emojis: return "🙂"
        case .numeric: return "123"
        case .symbolic: return "#+="
        default: return "???"
        }
    }
    
    var buttonWidth: CGFloat {
        switch self {
        case .none: return 10
        case .shift, .shiftDown, .backspace: return 60
        case .space: return 100
        default: return 50
        }
    }
    
    func buttonWidth(for distribution: UIStackView.Distribution) -> CGFloat {
        let adjust = distribution == .fillProportionally
        return adjust ? buttonWidth * 100 : buttonWidth
    }
    
    func tintColor(in viewController: KeyboardInputViewController) -> UIColor {
        let dark = useDarkAppearance(in: viewController)
        let asset = useDarkButton
            ? (dark ? Asset.Colors.darkSystemButtonText : Asset.Colors.lightSystemButtonText)
            : (dark ? Asset.Colors.darkButtonText : Asset.Colors.lightButtonText)
        return asset.color
    }
    
    func useDarkAppearance(in viewController: KeyboardInputViewController) -> Bool {
        let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
        return appearance == .dark
    }
    
    var useDarkButton: Bool {
        switch self {
        case .character, .image, .shiftDown, .space: return false
        default: return true
        }
    }
}
