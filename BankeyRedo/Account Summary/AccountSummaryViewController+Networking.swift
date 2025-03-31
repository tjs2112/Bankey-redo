//
//  AccountSummaryViewController+Networking.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/25/25.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

struct Account: Codable {
    
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account {
        
        return Account(id: "1", type: .Banking, name: "-Account Name-", amount: 2000.00, createdDateTime: Date())
        
    }
}

// MARK: - networking
extension AccountSummaryViewController {
    
    func fetchProfile(forUserID userID: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
        
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)")!
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    print("foo - success")
                    completion(.success(profile))
                    
                } catch {
                    print("foo - Decoding failure catch")
                    completion(.failure(.decodingError))
                }
            }
            
        }.resume()
        
    }
    

    
    func fetchAccounts(forUserID userID: String, completion: @escaping (Result<[Account], NetworkError>) -> Void) {
        
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)/accounts")!
        print(url)
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    print("error found nil")
                }
                if let response = response {
                    print(response)
                } else {
                    print("response found nil")
                }
                
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let accounts = try decoder.decode([Account].self, from: data)
                    print("foo - success")
                    completion(.success(accounts))
                    
                } catch {
                    print("foo - Accounts Decoding failure catch")
                    completion(.failure(.decodingError))
                }
            }
            
        }.resume()
        
    }
    
}


