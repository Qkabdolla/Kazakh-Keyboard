# Kazakh-Keyboard

Клавиатура для казахского языка(латиница и кириллица), основанная на открытой библиотеке KeyboardKit.

<img src="readme%20imgs/screen1.png" width="200" height="450"> &emsp;&emsp;&emsp;&emsp; <img src="readme%20imgs/screen2.png" width="200" height="450">

Для установки в свой проект необхадимо:
1) создать новый target и выбрать custom keyboard.
2) установить pod KeyboardKit(2.7.0).
3) добавить файлы которые находиться в /KazakhKeyboardKitTestKeyboard (кроме info.plist).
4) кастомизировать на свой лад.
5) после запуска не забудьте добавить клавиатуру в настройках симулятора.

Указав одинаковые для двух таргетов bundle display name в info.plist, в меню выбора клавиатур будет одно название.
