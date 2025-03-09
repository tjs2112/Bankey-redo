//
//  ViewController.swift
//  Bankey Re-do
//
//  Created by Todd Smith on 3/4/25.
//


    
    import UIKit
    
    class LoginViewController: UIViewController {
        
//        let stackView = UIStackView()
//        let label = UILabel()
        
        let appTitleLabel = UILabel()
        let taglineLabel = UILabel()
        let loginView = LoginView()
        let signInButton = UIButton(type: .system)
        let errorMessageLabel = UILabel()
        
        // Convenience Getters for Username and password
        var username: String? {
            return loginView.usernameTextField.text
        }
        var password: String? {
            return loginView.passwordtextField.text
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            style()
            layout()
        }
        
    }
    
    extension LoginViewController {
        
        private func style() {
            appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            appTitleLabel.text = "Bankey"
            appTitleLabel.textAlignment = .center
            appTitleLabel.font = .systemFont(ofSize: 36, weight: .bold)
            
            taglineLabel.translatesAutoresizingMaskIntoConstraints = false
            taglineLabel.text = "Your premium source for all things banking!"
            taglineLabel.numberOfLines = 0
            taglineLabel.textAlignment = .center
            taglineLabel.font = .systemFont(ofSize: 24, weight: .regular)
            
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
                appTitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
                appTitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
            ])
            
            NSLayoutConstraint.activate([
                loginView.topAnchor.constraint(equalToSystemSpacingBelow: taglineLabel.bottomAnchor, multiplier: 2),
                taglineLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
                taglineLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
            ])

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
        if username.isEmpty || password.isEmpty {
            configureView(withMesssage: "Usernamae / Password cannot be blank")
            return
        }
        
        // Check for hard coded correct password
        if username == "Kevin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMesssage: "Username / Password is incorrect")
        }
        
      
    }
    
    private func configureView(withMesssage message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.isHidden = false
    }
}



