//
//  AppDelegate.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/4/25.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    let accountSummaryViewController = AccountSummaryViewController()

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        

        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
//        window?.rootViewController = accountSummaryViewController
//        window?.rootViewController = loginViewController
//        window?.rootViewController = mainViewController
        onboardingContainerViewController.delegate = self
//        window?.rootViewController = onboardingContainerViewController
//        window?.rootViewController = OnboardingViewController()
        
        let vc = mainViewController
        vc.setstatusBar()
       
        // Appears to be not needed with change of setStatusBar to UINavigationAppearance()
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().backgroundColor = appColor
        
        window?.rootViewController = vc
        
        
        return true
    }
}

// MARK: - Protocol implementations
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        print("foo - did login")
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        print("foo - Onboarding is complete")
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        print("foo - did logout")
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    private func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        
    }
}

