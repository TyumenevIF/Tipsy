//
//  ViewController.swift
//  Tipsy
//
//  Created by Ilyas Tyumenev on 25.04.2023.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tips = 0.1
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)

        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        guard let buttonTitle = sender.currentTitle else { return }
        tips =  Double(String(buttonTitle.dropLast()))! / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberOfPeople = Int(sender.value)
        splitNumberLabel.text = "\(numberOfPeople)"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        guard let bill = billTextField.text else { return }
        billTotal = Double(bill)!
        let result = billTotal * (1 + tips) / Double(numberOfPeople)
        finalResult = String(format: "%.2f", result)
        
        performSegue(withIdentifier: "toResultsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultsVC = segue.destination as? ResultsViewController else { return }
        resultsVC.result = finalResult
        resultsVC.tips = Int(tips * 100)
        resultsVC.participants = numberOfPeople
    }
}

