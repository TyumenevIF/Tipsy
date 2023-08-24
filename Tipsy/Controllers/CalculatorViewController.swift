//
//  ViewController.swift
//  Tipsy
//
//  Created by Ilyas Tyumenev on 25.04.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
        
    var tips = 0.1
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    private let calculatorView = CalculatorView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorView.delegate = self
        view.backgroundColor =  UIColor(red: 248/255, green: 255/255, blue: 253/255, alpha: 1.0)
        setSubviews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setSubviews() {
        view.addSubview(calculatorView)
    }
    
    private func setupConstraints() {
        calculatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - CalculatorViewDelegate
extension CalculatorViewController: CalculatorViewDelegate {
    
    func calculatorView(_ view: CalculatorView, tipChanged sender: UIButton) {
        calculatorView.billTextField.endEditing(true)
        
        calculatorView.zeroPctButton.isSelected = false
        calculatorView.tenPctButton.isSelected = false
        calculatorView.twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        guard let buttonTitle = sender.currentTitle else { return }
        tips =  Double(String(buttonTitle.dropLast()))! / 100
    }
    
    func calculatorView(_ view: CalculatorView, stepperValueChanged sender: UIStepper) {
        numberOfPeople = Int(sender.value)
        calculatorView.splitNumberLabel.text = "\(numberOfPeople)"
    }
    
    func calculatorView(_ view: CalculatorView, calculatePressed button: UIButton) {
        guard let bill = calculatorView.billTextField.text else { return }
        if bill != "" {
            billTotal = Double(bill)!
            let result = billTotal * (1 + tips) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)            
        }
        
        let resultsVC = ResultsViewController()
        resultsVC.result = finalResult
        resultsVC.tips = Int(tips * 100)
        resultsVC.participants = numberOfPeople
        resultsVC.modalPresentationStyle = .automatic
        self.present(resultsVC, animated: true)
    }
}
