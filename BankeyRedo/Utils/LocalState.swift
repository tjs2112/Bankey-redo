//
//  LocalState.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/12/25.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case hasOnboarded
    }
    
    public static var hasOnboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue) 
        }
    }
    
}
