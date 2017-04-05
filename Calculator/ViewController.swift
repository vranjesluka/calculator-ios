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
    
    @IBOutlet fileprivate weak var display: UILabel!
    @IBOutlet fileprivate weak var history: UILabel!
    
    fileprivate let brain = CalculatorBrain()
    fileprivate var isTyping = false
    
    @IBAction fileprivate func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isTyping = true
        }
    }
    
    @IBAction fileprivate func operate(_ sender: UIButton) {
        if isTyping {
            brain.setOperand(displayValue)
            isTyping = false
        }
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol)
        }
        displayValue = brain.result
    }
    
    @IBAction fileprivate func point() {
        if !isTyping {
            display.text = "0."
            isTyping = true
        } else if !display.text!.contains(".") {
            display.text = display.text! + "."
        }
    }
    
    @IBAction fileprivate func clearAndPerformOperation(_ sender: UIButton) {
        history.text = " "
        display.text = "0"
        isTyping = false
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol)
        }
    }
    
    fileprivate var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
}

