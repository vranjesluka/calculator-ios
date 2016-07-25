//
//  ViewController.swift
//  Calculator
//
//  Created by Luka Vranješ on 25/07/16.
//  Copyright © 2016 Luka Vranješ. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    
    var isTyping: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (isTyping) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isTyping = true
        }
    }
    
}

