//
//  KazKeyboardActionHandler.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import KeyboardKit
import UIKit

/**
 
 This action handler inherits `StandardKeyboardActionHandler`
 and adds demo-specific functionality to it.
 
 */
class KazKeyboardActionHandler: StandardKeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(inputViewController: UIInputViewController) {
        keyboardShiftState = .lowercased
        super.init(
            inputViewController: inputViewController,
            hapticConfiguration: .standard
        )
    }
    
    
    // MARK: - Properties
    
    private var keyboardShiftState: KeyboardShiftState
    
    private var kazViewController: KeyboardViewController? {
        inputViewController as? KeyboardViewController
    }
    
    
    // MARK: - Actions
    
    override func longPressAction(for action: KeyboardAction, sender: Any?) -> StandardKeyboardActionHandler.GestureAction? {
        switch action {
        case .shift: return switchToCapsLockedKeyboard
        case .space: return switchToLatOrKir
        default: return super.longPressAction(for: action, sender: sender)
        }
    }
    
    override func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .character: return handleCharacter(action, for: sender)
        case .shift: return switchToUppercaseKeyboard
        case .shiftDown: return switchToLowercaseKeyboard
        case .space: return handleSpace(for: sender)
        case .switchToKeyboard(let type): return { [weak self] in self?.kazViewController?.keyboardType = type }
        default: return super.tapAction(for: action, sender: sender)
        }
    }
    
    
    // MARK: - Action Handling
    
    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.handle(gesture, on: action, sender: sender)
        kazViewController?.requestAutocompleteSuggestions()
    }
}

// MARK: - Actions

private extension KazKeyboardActionHandler {
    
    func alert(_ message: String) {
        guard let input = inputViewController as? KeyboardViewController else { return }
        input.alerter.alert(message: message, in: input.view, withDuration: 4)
    }
    
    func handleCharacter(_ action: KeyboardAction, for sender: Any?) -> GestureAction {
        let baseAction = super.tapAction(for: action, sender: sender)
        return { [weak self] in
            baseAction?()
            let isUppercased = self?.keyboardShiftState == .uppercased
            guard isUppercased else { return }
            self?.switchToAlphabeticKeyboard(.lowercased)
        }
    }
    
    func handleSpace(for sender: Any?) -> GestureAction {
        let baseAction = super.tapAction(for: .space, sender: sender)
        return { [weak self] in
            baseAction?()
            let isNonAlpha = self?.kazViewController?.keyboardType != .alphabetic(uppercased: false)
            guard isNonAlpha else { return }
            self?.switchToAlphabeticKeyboard(.lowercased)
        }
    }
    
    func switchToAlphabeticKeyboard(_ state: KeyboardShiftState) {
        keyboardShiftState = state
        kazViewController?.keyboardType = .alphabetic(uppercased: state.isUppercased)
    }
    
    func switchToLatOrKir() {
        guard let keyboardState = kazViewController?.keyType else {
            return switchToAlphabeticKeyboard(.lowercased)
        }
        
        switch keyboardState {
        case .latin: kazViewController?.keyType = .cyrillic
        case .cyrillic: kazViewController?.keyType = .latin
        }
        
        switchToAlphabeticKeyboard(.lowercased)
    }
    
    func switchToCapsLockedKeyboard() {
        switchToAlphabeticKeyboard(.capsLocked)
    }
    
    func switchToLowercaseKeyboard() {
        switchToAlphabeticKeyboard(.lowercased)
    }
    
    func switchToUppercaseKeyboard() {
        switchToAlphabeticKeyboard( .uppercased)
    }
}
