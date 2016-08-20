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
    
    @IBOutlet private weak var display: UILabel!
    @IBOutlet private weak var history: UILabel!
    
    private let brain = CalculatorBrain()
    private var isTyping = false
    
    @IBAction private func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if isTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isTyping = true
        }
    }
    
    @IBAction private func operate(sender: UIButton) {
        if isTyping {
            brain.setOperand(displayValue)
            isTyping = false
        }
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol)
        }
        displayValue = brain.result
    }
    
    @IBAction private func point() {
        if !isTyping {
            display.text = "0."
            isTyping = true
        } else if !display.text!.containsString(".") {
            display.text = display.text! + "."
        }
    }
    
    @IBAction private func clearAndPerformOperation(sender: UIButton) {
        history.text = " "
        display.text = "0"
        isTyping = false
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol)
        }
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
}

