//
//  CalculatorView.swift
//  Tipsy
//
//  Created by Ilyas Tyumenev on 17.08.2023.
//

import UIKit
import SnapKit

protocol CalculatorViewDelegate: AnyObject {
    func calculatorView(_ view: CalculatorView, tipChanged sender: UIButton)
    func calculatorView(_ view: CalculatorView, stepperValueChanged sender: UIStepper)
    func calculatorView(_ view: CalculatorView, calculatePressed button: UIButton)
}

class CalculatorView: UIView {
    
    // MARK: - Properties
    weak var delegate: CalculatorViewDelegate?
    
    private let enterBillTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter bill total"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let billTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 40)
        textField.textColor = UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0)
        textField.textAlignment = .center
        textField.placeholder = "e.g. 123.56"
        textField.minimumFontSize = 17
        textField.tintColor = .darkGray
        textField.borderStyle = .none
        return textField
    }()
    
    lazy var billStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 26
        [self.enterBillTotalLabel,
         self.billTextField].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 215/255, green: 249/255, blue: 235/255, alpha: 1.0)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let selectTipLabel: UILabel = {
        let label = UILabel()
        label.text = "Select tip"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var zeroPctButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("0%", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        button.setTitleColor(UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0), for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 10
        button.tintColor = UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0)
        button.addTarget(self, action: #selector(tipChanged), for: .touchUpInside)
        return button
    }()
    
    lazy var tenPctButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("10%", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        button.setTitleColor(UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0), for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 10
        button.tintColor = UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0)
        button.addTarget(self, action: #selector(tipChanged), for: .touchUpInside)
        return button
    }()
    
    lazy var twentyPctButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("20%", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        button.setTitleColor(UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0), for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 10
        button.tintColor = UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0)
        button.addTarget(self, action: #selector(tipChanged), for: .touchUpInside)
        return button
    }()
    
    lazy var selectTipStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 0
        [self.zeroPctButton,
         self.tenPctButton,
         self.twentyPctButton].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private let chooseSplitLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Split"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let splitNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.font = .systemFont(ofSize: 35)
        label.textColor = UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 2
        stepper.maximumValue = 25
        stepper.value = 2
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        return stepper
    }()

    lazy var chooseSplitStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 27
        [self.splitNumberLabel,
         self.stepper].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 26
        [self.selectTipLabel,
         self.selectTipStackView,
         self.chooseSplitLabel,
         self.chooseSplitStackView].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        button.setTitleColor(UIColor(red: 248/255, green: 255/255, blue: 253/255, alpha: 1.0), for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(calculatePressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addViews() {
        mainView.addSubview(mainStackView)
        addSubview(billStackView)
        addSubview(mainView)
        addSubview(calculateButton)
    }
    
    private func addConstraints() {
        enterBillTotalLabel.snp.makeConstraints { make in
            make.leading.equalTo(billStackView.snp.leading).inset(50)
            make.trailing.equalTo(billStackView.snp.trailing).inset(50)
            make.height.equalTo(30)
        }
        
        billTextField.snp.makeConstraints { make in
            make.leading.equalTo(billStackView.snp.leading)
            make.trailing.equalTo(billStackView.snp.trailing)
            make.height.equalTo(48)
        }
        
        billStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(billStackView.snp.bottom).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        selectTipLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainStackView.snp.leading).inset(30)
            make.trailing.equalTo(mainStackView.snp.trailing).inset(30)
            make.height.equalTo(30)
        }
        
        zeroPctButton.snp.makeConstraints { make in
            make.width.equalTo(twentyPctButton.snp.width)
            make.width.greaterThanOrEqualTo(60)
            make.height.equalTo(54)
        }
        
        tenPctButton.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
        
        twentyPctButton.snp.makeConstraints { make in
            make.width.equalTo(zeroPctButton.snp.width)
            make.height.equalTo(54)
        }
        
        selectTipStackView.snp.makeConstraints { make in
            make.leading.equalTo(mainStackView.snp.trailing)
            make.trailing.equalTo(mainStackView.snp.trailing)
        }
        
        chooseSplitLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainStackView.snp.leading).inset(30)
            make.trailing.equalTo(mainStackView.snp.trailing).inset(30)
            make.height.equalTo(30)
        }
        
        splitNumberLabel.snp.makeConstraints { make in
            make.width.equalTo(93)
            make.height.equalTo(29)
        }
        
        stepper.snp.makeConstraints { make in
            make.width.equalTo(94)
            make.height.equalTo(29)
        }
        
        chooseSplitStackView.snp.makeConstraints { make in
        }
                
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).inset(20)
            make.leading.equalTo(mainView.snp.leading).inset(20)
            make.trailing.equalTo(mainView.snp.trailing).inset(20)
        }
        
        calculateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(200)
            make.height.equalTo(54)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - Target Actions
private extension CalculatorView {
    
    @objc func tipChanged(_ sender: UIButton) {
        delegate?.calculatorView(self, tipChanged: sender)
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        delegate?.calculatorView(self, stepperValueChanged: sender)
    }
    
    @objc func calculatePressed(_ sender: UIButton) {
        delegate?.calculatorView(self, calculatePressed: sender)
    }
}
