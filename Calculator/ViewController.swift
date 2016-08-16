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
    @IBOutlet weak var history: UILabel!
    
    var isTyping = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if isTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isTyping = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if isTyping {
            enter()
        }
        history.text = history.text! + ", " + operation
        switch operation {
        case "+": performOperation { $1 + $0 }
        case "−": performOperation { $1 - $0 }
        case "×": performOperation { $1 * $0 }
        case "÷": performOperation { $1 / $0 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        case "π":
            operandStack.append(M_PI)
            displayValue = M_PI
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    @objc(performOperationSingle:)
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        isTyping = false
        operandStack.append(displayValue)
        history.text = history.text! + ", " + String(displayValue)
        print("operand stack = \(operandStack)")
    }
    
    @IBAction func point() {
        if !isTyping {
            display.text = "0."
            isTyping = true
        } else if !display.text!.containsString(".") {
            display.text = display.text! + "."
        }
    }
    
    @IBAction func clear() {
        history.text = ""
        display.text = "0"
        operandStack.removeAll()
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            isTyping = false
        }
    }
}

