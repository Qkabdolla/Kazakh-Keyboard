//
//  KazAutocomplateLabel.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit
import KeyboardKit

class KazAutocomplateLabel: UILabel {

    convenience init(word: String, proxy: UITextDocumentProxy) {
        self.init(frame: .zero)
        self.proxy = proxy
        text = word
        textAlignment = .center
        accessibilityTraits = .button
        textColor = textColor(for: proxy)
        addTapAction { [weak self] in
            self?.proxy?.replaceCurrentWord(with: word)
        }
    }
    
    private weak var proxy: UITextDocumentProxy?
}

private extension KazAutocomplateLabel {
    
    func textColor(for proxy: UITextDocumentProxy) -> UIColor {
        let asset = proxy.keyboardAppearance == .dark
            ? Asset.Colors.darkButtonText
            : Asset.Colors.lightButtonText
        return asset.color
    }
}
