//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Luka Vranješ on 16/08/16.
//  Copyright © 2016 Luka Vranješ. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    fileprivate enum Operation {
        case operand(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clear
    }
    
    fileprivate let knownOperations = [
        "+" : Operation.binaryOperation(+),
        "−" : Operation.binaryOperation(-),
        "×" : Operation.binaryOperation(*),
        "÷" : Operation.binaryOperation(/),
        "√" : Operation.unaryOperation(sqrt),
        "sin" : Operation.unaryOperation(sin),
        "cos" : Operation.unaryOperation(cos),
        "tg" : Operation.unaryOperation(tan),
        "ctg" : Operation.unaryOperation() {1 / tan($0)},
        "±" : Operation.unaryOperation() { -$0 },
        "π" : Operation.operand(M_PI),
        "e" : Operation.operand(M_E),
        "=" : Operation.equals,
        "C" : Operation.clear
    ]
    
    fileprivate var accumulator = 0.0
    fileprivate var pending : (binaryFunction: (Double, Double) -> Double, firstOperand: Double)?
    
    var description: String {
        get {
            return " "
        }
    }
    
    var isPartialResult: Bool {
        get {
            return pending != nil
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    func performOperation(_ symbol: String) {
        if let operation = knownOperations[symbol] {
            switch operation {
            case .operand(let value):
                accumulator = value
            case .unaryOperation(let operation):
                accumulator = operation(accumulator)
            case .binaryOperation(let operation):
                executePendginBinaryOperation()
                pending = (operation, accumulator)
            case .equals:
                executePendginBinaryOperation()
            case .clear:
                clear()
            }
        }
    }
    
    fileprivate func executePendginBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    fileprivate func clear() {
        accumulator = 0
        pending = nil
    }
}
