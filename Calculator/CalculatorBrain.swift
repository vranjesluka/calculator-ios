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
        case Clear
    }
    
    private let knownOperations = [
        "+" : Operation.BinaryOperation(+),
        "−" : Operation.BinaryOperation(-),
        "×" : Operation.BinaryOperation(*),
        "÷" : Operation.BinaryOperation(/),
        "√" : Operation.UnaryOperation(sqrt),
        "sin" : Operation.UnaryOperation(sin),
        "cos" : Operation.UnaryOperation(cos),
        "tg" : Operation.UnaryOperation(tan),
        "ctg" : Operation.UnaryOperation() {1 / tan($0)},
        "±" : Operation.UnaryOperation() { -$0 },
        "π" : Operation.Operand(M_PI),
        "e" : Operation.Operand(M_E),
        "=" : Operation.Equals,
        "C" : Operation.Clear
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
            case .Equals:
                executePendginBinaryOperation()
            case .Clear:
                clear()
            }
        }
    }
    
    private func executePendginBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private func clear() {
        accumulator = 0
        pending = nil
    }
}