//
//  OnboardingViewController.swift
//  Bankey Re-do
//
//  Created by Todd Smith on 3/11/25.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
}

extension OnboardingViewController {
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = .systemBackground
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "delorean")
                
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80's"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        
        
    }
    
    private func layout() {
        
        view.addSubview(stackView)
        //  Edge to edge stack view with system spacing
                NSLayoutConstraint.activate([
                    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
                    view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
                ])
        
        //  Stackview is only the size of the label
//        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
    }
    
}
