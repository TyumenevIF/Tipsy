//
//  ResultsView.swift
//  Tipsy
//
//  Created by Ilyas Tyumenev on 18.08.2023.
//

import UIKit

protocol ResultsViewDelegate: AnyObject {
    func resultsView(_ view: ResultsView, recalculatePressed button: UIButton)
}

class ResultsView: UIView {
    
    // MARK: - Properties
    weak var delegate: ResultsViewDelegate?
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 215/255, green: 249/255, blue: 235/255, alpha: 1.0)
        view.contentMode = .scaleToFill
        return view
    }()
        
    let totalPerPersonLabel: UILabel = {
        let label = UILabel()
        label.text = "Total per person"
        label.font = .systemFont(ofSize: 30)
        label.textColor = UIColor(red: 149/255, green: 154/255, blue: 153/255, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 45)
        label.textColor = UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()    
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.textColor = UIColor(red: 149/255, green: 154/255, blue: 153/255, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var recalculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recalculate", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35)
        button.setTitleColor(UIColor(red: 248/255, green: 255/255, blue: 253/255, alpha: 1.0), for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = UIColor(red: 0/255, green: 176/255, blue: 107/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(recalculatePressed), for: .touchUpInside)
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
        addSubview(topView)
        addSubview(totalPerPersonLabel)
        addSubview(totalLabel)
        addSubview(settingsLabel)
        addSubview(recalculateButton)
    }
    
    private func addConstraints() {
        topView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(totalPerPersonLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        totalPerPersonLabel.snp.makeConstraints { make in
            make.leading.equalTo(topView.snp.leading)
            make.trailing.equalTo(topView.snp.trailing)
            make.centerY.equalTo(topView.snp.centerY)
            make.height.equalTo(36)
        }
        
        settingsLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).inset(5)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(50)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(50)
            make.height.equalTo(117)
        }
        
        recalculateButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(200)
            make.height.equalTo(54)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - Target Actions
private extension ResultsView {
    
    @objc func recalculatePressed(_ button: UIButton) {
        delegate?.resultsView(self, recalculatePressed: button)
    }
}
