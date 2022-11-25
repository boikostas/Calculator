//
//  ViewController.swift
//  Calculator V2.0
//
//  Created by Стас Бойко on 18.07.2022.
//

import UIKit

enum Operation {
    case addition, substraction, dividing, multiplying, none
}

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var pointButton: UIButton!
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var percentageButton: UIButton!
        
    var number1: Float?
    var number2: Float = 0
    var result: Float = 0
    var operation = Operation.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.minimumScaleFactor = 0.5
    }

    // MARK: - Clear button
    @IBAction func cleanButton(_ sender: Any) {
        numberLabel.text = "0"
        number1 = 0
        result = 0
    }
    
    // MARK: - +/-
    @IBAction func plusMinusButton(_ sender: Any) {
        if numberLabel.text?.first == "-" {
            numberLabel.text?.removeFirst()
        } else {
            numberLabel.text?.insert("-", at: numberLabel.text!.startIndex)
        }
        
    }
    
    // MARK: - %
    @IBAction func percentageCalculation(_ sender: Any) {
        labelToNumber()
        guard let number = number1 else { return }
        result = number / 100
        displayResult()
        number1 = 0
    }
    
    // MARK: - Numbers
    @IBAction func pressNumber(_ sender: UIButton) {
        checkAndPass(sender.titleLabel?.text ?? "")
    }
    
    // MARK: - /
    @IBAction func devide(_ sender: UIButton) {
        labelToNumber()
        operation = .dividing
        sender.backgroundColor = .white
        sender.tintColor = .yellow
    }
    
    // MARK: - *
    @IBAction func multiply(_ sender: Any) {
        labelToNumber()
        operation = .multiplying
    }
    
    // MARK: - -
    @IBAction func subtract(_ sender: Any) {
        labelToNumber()
        operation = .substraction
    }
    
    // MARK: - +
    @IBAction func add(_ sender: Any) {
        labelToNumber()
        operation = .addition
    }
    
    // MARK: - =
    @IBAction func equals(_ sender: Any) {
        calculateResult()
        displayResult()
        number1 = 0
    }
    
    //MARK: - Calculare result
    func calculateResult() {
        guard let number = number1 else { return }
            
        if number2 == 0 {
            guard let num2 = Float(numberLabel.text ?? "") else { return }
            number2 = num2
        }
            
        if Float(numberLabel.text ?? "") == result {
            switch operation {
                 case .addition:
                    result += number + number2
                 case .substraction:
                     result += number - number2
                 case .dividing:
                     result = result / number2
                 case .multiplying:
                    result = result * number2
                 case .none:
                     return
                 }
        } else {
            guard let num2 = Float(numberLabel.text ?? "") else { return }
            number2 = num2
            
            switch operation {
                 case .addition:
                     result = number + number2
                 case .substraction:
                     result = number - number2
                 case .dividing:
                     result = number / number2
                 case .multiplying:
                     result = number * number2
                 case .none:
                     return
                 }
        }
    }
    
    // MARK: - Display result
    func displayResult() {
        if result.description.hasSuffix(".0") {
            numberLabel.text = String(Int(result))
        } else {
            numberLabel.text = String(result)
        }
    }
    
    // MARK: - .
    @IBAction func pointAdd(_ sender: Any) {
        guard let numberText = numberLabel.text else { return }
        if !numberText.contains(".") {
            if numberText == "0" || numberText == "-0" {
                numberLabel.text?.append(".")
            } else if Float(numberText) == number1 {
                numberLabel.text?.removeAll()
                numberLabel.text?.append("0.")
            } else if Float(numberText) == result {
                numberLabel.text?.removeAll()
                numberLabel.text?.append("0.")
            } else {
                numberLabel.text?.append(".")
            }
        }
    }
    
    // MARK: - Check and pass
    func checkAndPass(_ num: String) {
        if numberLabel.text == "0." {
            numberLabel.text?.append(num)
        } else if numberLabel.text == "0" {
            numberLabel.text?.removeAll()
            numberLabel.text?.append(num)
        } else if numberLabel.text?.first == "-" && numberLabel.text?.last == "0" && numberLabel.text?.count == 2  {
            numberLabel.text?.removeLast()
            numberLabel.text?.append(num)
        } else if numberLabel.text?.first == "-" && numberLabel.text?[(numberLabel.text?.index(numberLabel.text!.startIndex, offsetBy: 1))!] == "0" && numberLabel.text?[(numberLabel.text?.index(numberLabel.text!.startIndex, offsetBy: 2))!] == "." && numberLabel.text?.count == 3 {
            numberLabel.text?.append(num)
        } else if Float(numberLabel.text ?? "") == number1 {
                numberLabel.text?.removeAll()
                numberLabel.text?.append(num)
        } else if Float(numberLabel.text ?? "") == result && result != 0 {
            numberLabel.text?.removeAll()
            result = 0
            numberLabel.text?.append(num)
        } else {
            numberLabel.text?.append(num)
        }
    }
    
    // MARK: - Label to number
    func labelToNumber() {
        guard let num1 = Float(numberLabel.text ?? "") else {return}
        number1 = num1
    }
}

