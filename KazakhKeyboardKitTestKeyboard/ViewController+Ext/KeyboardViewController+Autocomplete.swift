//
//  KeyboardViewController+Autocomplete.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func requestAutocompleteSuggestions() {
        let word = textDocumentProxy.currentWord ?? ""
        autocompleteProvider.autocompleteSuggestions(for: word) { [weak self] in
            self?.handleAutocompleteSuggestionsResult($0)
        }
    }
    
    func resetAutocompleteSuggestions() {
        autocompleteToolbar.reset()
    }
}

private extension KeyboardViewController {
    
    func handleAutocompleteSuggestionsResult(_ result: AutocompleteResult) {
        switch result {
        case .failure(let error): print(error.localizedDescription)
        case .success(let result): autocompleteToolbar.update(with: result)
        }
    }
}
