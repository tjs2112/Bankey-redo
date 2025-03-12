//
//  DummyViewController.swift
//  Bankey Re-do
//
//  Created by Todd Smith on 3/12/25.
//

import UIKit

class DummyViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton(type: .system)
    weak var logoutDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
}

extension DummyViewController {
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
//        stackView.backgroundColor = .orange
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: [])
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .primaryActionTriggered)
        
         
    }
    
    private func layout() {
        
        view.addSubview(stackView)
        //  Edge to edge stack view with system spacing
        //        NSLayoutConstraint.activate([
        //            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        //            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
        //            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        //        ])
        
        //  Stackview is only the size of the label
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        
    }
    
}

// MARK: - Actions

extension DummyViewController {
    
    @objc func logoutButtonPressed() {
        print("foo - Logout Button Pressed")
        logoutDelegate?.didLogout()
    }
}
