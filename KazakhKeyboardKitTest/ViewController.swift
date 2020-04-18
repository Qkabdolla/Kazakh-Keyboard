//
//  ViewController.swift
//  KazakhKeyboardKitTest
//
//  Created by Мадияр on 4/18/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView? {
         didSet { textView?.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

