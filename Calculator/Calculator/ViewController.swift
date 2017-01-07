//
//  ViewController.swift
//  Calculator
//
//  Created by Nicolas Aubry on 11/10/16.
//  Copyright © 2016 Nicolas Aubry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyIndisplay = display.text!
            display.text = textCurrentlyIndisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func touchDot(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping && display.text!.contains(".") == false {
            display.text = display.text! + "."
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func toucAllClear(_ sender: UIButton) {
        brain.reset()
        userIsInTheMiddleOfTyping = false
        display.text = "0"
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

