//
//  ViewController.swift
//  Calculator
//
//  Created by Soeng Saravit on 10/25/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currentNumberLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    var currentNumber: Double = 0
    var tempResult: Double = 0
    var result: Double = 0
    var operation: String = ""
    var calculatedOperation = ""
    var isEqualPressed: Bool = false
    
   
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func numblerClick(_ sender: UIButton) {
        let countDigit = currentNumberLabel.text!.count + 1
//        print(countDigit)
        if countDigit <= 11 {
            if currentNumberLabel.text == "0" {
                currentNumberLabel.text = sender.currentTitle!
            } else {
                currentNumberLabel.text = currentNumberLabel.text! + sender.currentTitle!
            }
        }
    }
    
    @IBAction func equalClick(_ sender: Any) {
        
        isEqualPressed = true

        if currentNumberLabel.text == "0" {
            currentNumberLabel.text = String(format: "%g", result)
        } else {
            statusLabel.text = statusLabel.text! + currentNumberLabel.text!
            switch operation {
            case "+":
                result += Double(currentNumberLabel.text!)!
            case "-":
                result -= Double(currentNumberLabel.text!)!
            case "×":
                result *= Double(currentNumberLabel.text!)!
            case "÷":
                if Double(currentNumberLabel.text!)! == 0 {
                    currentNumberLabel.text = "∞"
                     statusLabel.text = "∞"
                    return
                }
                result /= Double(currentNumberLabel.text!)!
//            case "%":
//                let a = statusLabel.text!
//                let b = Double(currentNumberLabel.text!)!
//                print("a : \(a)")
//                print("b : \(b)")
//                result = a.truncatingRemainder(dividingBy: b)
            default:
                print("Something is wroing")
            }
            
            // Display result to label
            statusLabel.text = "\(statusLabel.text!) = \(String(format: "%g", result))"
            currentNumberLabel.text = String(format: "%g", result)
        }
        
    }
    
    @IBAction func operationClick(_ sender: UIButton) {
        currentNumber = Double(currentNumberLabel.text!)!
        operation = sender.currentTitle!
        if isEqualPressed == true {
            statusLabel.text = ""
            isEqualPressed = false
            result = 0
            calculatedOperation = ""
        }
        
        if currentNumber != 0 && statusLabel.text != " " {
            
            if operation != "+/-" {
                if statusLabel.text! == "" {
                    statusLabel.text = currentNumberLabel.text! + operation
                } else {
                    statusLabel.text = statusLabel.text! + currentNumberLabel.text! + operation
                    currentNumber = Double(currentNumberLabel.text!)!
                }
            }
            
            // Check if the digit is +/-, then change its symbole
            if operation == "+/-" {
                var curNumber: String = currentNumberLabel.text!
                
                if let i = curNumber.characters.index(of: "-") {
                    curNumber.remove(at: i)
                    currentNumberLabel.text = curNumber
                } else {
                    currentNumberLabel.text = "-\(curNumber)"
                }
                return
            }

       
            switch calculatedOperation {
            case "+":
                result += currentNumber
                currentNumberLabel.text = "0"
                
            case "-":
                result -= currentNumber
                currentNumberLabel.text = "0"
                
            case "×":
//                print("work")
//                if result == 0 {
//                    result = 1
//                }
                result *= currentNumber
                currentNumberLabel.text = "0"
                
            case "÷":
                if currentNumberLabel.text == "0" {
                    currentNumber = 0
                }
                result /= currentNumber
                currentNumberLabel.text = "0"
           
            default:
                result = currentNumber
                currentNumberLabel.text = "0"
            }

            print("result:  \(result)")
            calculatedOperation = sender.currentTitle!

        }
        
       
    }
    
    
    @IBAction func clearNumber(_ sender: UIButton) {
        
        currentNumberLabel.text = "0"
        statusLabel.text = ""
        result = 0
        operation = ""
        calculatedOperation = ""
        
    }
    
    
}



@IBDesignable class customButton: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
           self.layer.cornerRadius = self.cornerRadius
        }
    }
}
