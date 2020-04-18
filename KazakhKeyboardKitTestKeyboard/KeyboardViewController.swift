//
//  KeyboardViewController.swift
//  KazakhKeyboardKitTestKeyboard
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit
import KeyboardKit

/**
 Это демонстрационное приложение обрабатывает системные действия как обычно (например, изменение
  клавиатура, пробел, новая строка и т. д.), вводит строки и смайлики
  в текстовый прокси и обрабатывает самые правые изображения в
  смайликовую клавиатуру, скопировав их в монтажный стол и нажмите
  сохранение их в фотоальбоме пользователя при длительном нажатии.
  
  ВАЖНО: чтобы использовать эту демонстрационную клавиатуру, вы должны включить ее
  в настройках системы («Настройки / Общие / Клавиатуры»), тогда дайте
  это полный доступ (для этого необходимо включить `RequestsOpenAccess`
  в `Info.plist`), если вы хотите использовать кнопки изображений. Вы должны
  также добавьте `NSPhotoLibraryAddUsageDescription` на ваш хост
  `Info.plist` приложения, если вы хотите иметь возможность сохранять изображения в
  фотоальбом. Об этом уже позаботились в этой демонстрации
  приложение, так что вы можете просто скопировать настройки в свое собственное приложение.
  
  Клавиатура настроена в `viewDidAppear (...)`, так как это
  когда 'needsInputModeSwitchKey` первым получает правильное значение.
  До этого момента значение равно `true`, даже если оно должно быть
  `False`. Если вы найдете способ решить эту ошибку, вы можете настроить
  клавиатура раньше.
  
  Автозаполнение частей этого класса является первой итерацией
  поддержки автозаполнения в KeyboardKit. Намерение состоит в том, чтобы
  переместите эти части в `KeyboardInputViewController` и новый
  API для работы с автозаполнением.
  
  ** ВАЖНО ** `textWillChange` и` textDidChange` не
  срабатывает, когда пользователь вводит текст и отправляет его на прокси. Это
  однако работает, когда текстовый курсор меняет свою позицию, поэтому
  Поэтому я использую (надеюсь, временный) взломать, начав
  таймер, который срабатывает каждую секунду и перемещает курсор. поскольку
  это мерзкий взлом, возможно, еще предстоит выяснить сторону
  эффекты. Если это так, пожалуйста, дайте мне знать.
 */

enum AlphabeticKeyboardType {
    case latin
    case cyrillic
}

class KeyboardViewController: KeyboardInputViewController {
    
    var keyType: AlphabeticKeyboardType = .cyrillic
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardActionHandler = KazKeyboardActionHandler(inputViewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboard()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupKeyboard(for: size)
    }
    
    
    // MARK: - Keyboard Functionality
    
    override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        requestAutocompleteSuggestions()
    }
    
    override func selectionWillChange(_ textInput: UITextInput?) {
        super.selectionWillChange(textInput)
        autocompleteToolbar.reset()
    }
    
    override func selectionDidChange(_ textInput: UITextInput?) {
        super.selectionDidChange(textInput)
        autocompleteToolbar.reset()
    }
    
    
    // MARK: - Properties
    
    let alerter = ToastAlert()
    
    var keyboardType = KeyboardType.alphabetic(uppercased: false) {
        didSet { setupKeyboard() }
    }
    
    
    // MARK: - Autocomplete
    
    lazy var autocompleteProvider = KazAutocomplateSuggestionProvider()
    
    lazy var autocompleteToolbar: AutocompleteToolbar = {
        AutocompleteToolbar(textDocumentProxy: textDocumentProxy)
    }()
}
