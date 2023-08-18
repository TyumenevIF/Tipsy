//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Ilyas Tyumenev on 26.04.2023.
//

import UIKit

class ResultsViewController: UIViewController {
    
    private let resultsView = ResultsView()
    var result = "0.0"
    var tips = 10
    var participants = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 248/255, green: 255/255, blue: 253/255, alpha: 1.0)
        
        resultsView.delegate = self
        resultsView.totalLabel.text = result
        resultsView.settingsLabel.text = "Split between \(participants) people, with \(tips)% tip."
        
        setViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setViews() {
        view.addSubview(resultsView)
    }
    
    private func setupConstraints() {
        resultsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - ResultsViewDelegate
extension ResultsViewController: ResultsViewDelegate {
    
    func resultsView(_ view: ResultsView, recalculatePressed button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
