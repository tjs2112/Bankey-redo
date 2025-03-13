//
//  UIViewController+Utils.swift
//  Bankey Re-do
//
//  Created by Todd Smith on 3/13/25.
//

import UIKit

extension UIViewController {
    
//    Old - deprecated
//    func setStatusBar() {
//        let statusBarSize = UIApplication.shared.statusBarFrame.size
//        let frame = CGRect(origin: .zero, size: statusBarSize)
//        let statusbarView = UIView(frame: frame)
//        
//        statusbarView.backgroundColor = appColor
//        view.addSubview(statusbarView)
//    }
    
    func setstatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()  // to hide Navigation bar line
        navBarAppearance.backgroundColor = appColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
