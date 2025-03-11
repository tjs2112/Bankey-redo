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
    
    var heroImageName: String?
    var titleText: String?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    init(heroImageName: String, titleText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OnboardingViewController {
    
    private func style() {
        view.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = .systemBackground
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        guard let heroImageName = heroImageName else { return }
        imageView.image = UIImage(named: heroImageName)
                
        label.translatesAutoresizingMaskIntoConstraints = false
        guard let titleText = titleText else {return}
        label.text = titleText
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
