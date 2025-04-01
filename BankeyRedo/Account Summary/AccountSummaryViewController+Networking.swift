//
//  AccountSummaryViewController+Networking.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/25/25.
//

import Foundation


extension AccountSummaryViewController {
    
    func fetchAccounts(forUserID userID: String, completion: @escaping (Result<[Account], NetworkError>) -> Void) {
        
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)/accounts")!
        print(url)
        
        //  Change from epemeral to default to support caching for quicker displays.  .ephemeral is good for testing sekleton loaders and such
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        var request = URLRequest(url: url)
        
        // comment out to restore caching
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
    
    



