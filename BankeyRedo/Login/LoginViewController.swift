//
//  ViewController.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/4/25.
//


    
    import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

    protocol LoginViewControllerDelegate: AnyObject {
        func didLogin()
}
    
    class LoginViewController: UIViewController {
        
//        let stackView = UIStackView()
//        let label = UILabel()
        
        let appTitleLabel = UILabel()
        let taglineLabel = UILabel()
        let loginView = LoginView()
        let signInButton = UIButton(type: .system)
        let errorMessageLabel = UILabel()
        
        weak var delegate: LoginViewControllerDelegate?
        
        // Convenience Getters for Username and password
        var username: String? {
            return loginView.usernameTextField.text
        }
        var password: String? {
            return loginView.passwordtextField.text
        }
        
        // Animation
        var leadingEdgeOnScreen: CGFloat = 16
        var leadingEdgeOffScreen: CGFloat = -1000
        
        var appTitleLeadingAnchor: NSLayoutConstraint?
        var taglineLeadingAnchor: NSLayoutConstraint?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            style()
            layout()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            animate()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
            signInButton.configuration?.showsActivityIndicator = false
            loginView.usernameTextField.text = ""
            loginView.passwordtextField.text = ""
        }
        
    }
    
    extension LoginViewController {
        
        private func style() {
            appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            appTitleLabel.text = "Bankey"
            appTitleLabel.textAlignment = .center
            appTitleLabel.font = .systemFont(ofSize: 36, weight: .bold)
            appTitleLabel.alpha = 0
            
            taglineLabel.translatesAutoresizingMaskIntoConstraints = false
            taglineLabel.text = "Your premium source for all things banking!"
            taglineLabel.numberOfLines = 0
            taglineLabel.textAlignment = .center
            taglineLabel.font = .systemFont(ofSize: 24, weight: .regular)
            taglineLabel.alpha = 0
            
            loginView.translatesAutoresizingMaskIntoConstraints = false
            loginView.backgroundColor = .secondarySystemBackground
            
            signInButton.translatesAutoresizingMaskIntoConstraints = false
            signInButton.configuration = .filled()
            signInButton.configuration?.imagePadding = 8
            signInButton.setTitle("Sign In", for: [])
            signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
            
            errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
            errorMessageLabel.textColor = .systemRed
            errorMessageLabel.textAlignment = .center
            errorMessageLabel.isHidden = false
            errorMessageLabel.numberOfLines = 0
            
//            stackView.translatesAutoresizingMaskIntoConstraints = false
//            stackView.axis = .vertical
//            stackView.spacing = 20
//            stackView.backgroundColor = .orange
//            
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.text = "Welcome"
//            label.textAlignment = .center
//            label.font = .preferredFont(forTextStyle: .largeTitle)
            
        }
        
        private func layout() {
            
//            view.addSubview(stackView)
            view.addSubview(appTitleLabel)
            view.addSubview(taglineLabel)
            view.addSubview(loginView)
            view.addSubview(signInButton)
            view.addSubview(errorMessageLabel)
            
            //  Edge to edge stack view with system spacing
            NSLayoutConstraint.activate([
                taglineLabel.topAnchor.constraint(equalToSystemSpacingBelow: appTitleLabel.bottomAnchor, multiplier: 2),
//                appTitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),  // to enable animation
                appTitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
            ])
            
            // Set initial off screen position for animation
            appTitleLeadingAnchor = appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
            appTitleLeadingAnchor?.isActive = true
            
            NSLayoutConstraint.activate([
                loginView.topAnchor.constraint(equalToSystemSpacingBelow: taglineLabel.bottomAnchor, multiplier: 2),
                taglineLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
            ])
            
            // Set initial off screen position for animation
            taglineLeadingAnchor = taglineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
            taglineLeadingAnchor?.isActive = true

            NSLayoutConstraint.activate([
                loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
                view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
            ])
            
            NSLayoutConstraint.activate([
                signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
                signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
                signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2)
            ])
            
            NSLayoutConstraint.activate([
                errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
                errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
                errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
            ])
            
            
            
            //  Stackview is only the size of the label
//            NSLayoutConstraint.activate([
//                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            ])
            
//            stackView.addArrangedSubview(label)
            
        }
        
    }

// MARK: Actions
extension LoginViewController {
    
    @objc func signInTapped(sender: UIButton) {
        // reset any previous possible error message
        errorMessageLabel.isHidden = true
        login()
        
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username or Password is NIL")
            return
        }
        
        // Check for either username or password being empty
//        if username.isEmpty || password.isEmpty {
//            configureView(withMesssage: "Usernamae / Password cannot be blank")
//            return
//        }
        
        // Check for hard coded correct password
        if username == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMesssage: "Username / Password is incorrect")
        }
        
      
    }
    
    private func configureView(withMesssage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
        shake()
    }
}

// MARK: - Animations

extension LoginViewController {
    
    private func animate() {
        let duration = 0.8
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.appTitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.taglineLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let animator3 = UIViewPropertyAnimator(duration: duration * 2, curve: .easeInOut) {
            self.appTitleLabel.alpha = 1
            self.taglineLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        
        animator1.startAnimation()
        
        animator2.startAnimation(afterDelay: 0.2)
        
        animator3.startAnimation(afterDelay: 0.2)
        
    }
    
    private func shake() {
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.18, 0.5, 0.80, 1]
        animation.duration = 0.4
        animation.isAdditive = true

        signInButton.layer.add(animation, forKey: "shake")
        
    }
}

