//
//  AppDelegate.swift
//  Bankey Re-do
//
//  Created by Todd Smith on 3/4/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    var isOnboardingComplete: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        

        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        window?.rootViewController = loginViewController
        onboardingContainerViewController.delegate = self
        dummyViewController.logoutDelegate = self
//        window?.rootViewController = onboardingContainerViewController
//        window?.rootViewController = OnboardingViewController()
        
        return true
    }
}

// MARK: - Protocol implementations
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        print("foo - did login")
        if isOnboardingComplete {
            setRootViewController(dummyViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        print("foo - Onboarding is complete")
        isOnboardingComplete = true
        setRootViewController(dummyViewController)
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

