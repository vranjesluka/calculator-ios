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
    private enum Operation {
        case Operand(Double)
        case UnaryOperation(Double -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    private let knownOperations = [
        "+" : Operation.BinaryOperation(+),
        "−" : Operation.BinaryOperation(-),
        "×" : Operation.BinaryOperation(*),
        "÷" : Operation.BinaryOperation(/),
        "√" : Operation.UnaryOperation(sqrt),
        "sin" : Operation.UnaryOperation(sin),
        "cos" : Operation.UnaryOperation() { -$0 },
        "±" : Operation.UnaryOperation(cos),
        "π" : Operation.Operand(M_PI),
        "e" : Operation.Operand(M_E),
        "=" : Operation.Equals
    ]
    
    private var accumulator = 0.0
    private var pending : (binaryFunction: (Double, Double) -> Double, firstOperand: Double)?
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = knownOperations[symbol] {
            switch operation {
            case .Operand(let value):
                accumulator = value
            case .UnaryOperation(let operation):
                accumulator = operation(accumulator)
            case .BinaryOperation(let operation):
                executePendginBinaryOperation()
                pending = (operation, accumulator)
            case .Equals():
                executePendginBinaryOperation()
            }
        }
    }
    
    private func executePendginBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
}