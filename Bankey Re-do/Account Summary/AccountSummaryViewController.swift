//
//  AccountSummaryViewController.swift
//  Bankey Re-do
//
//  Created by Todd Smith on 3/14/25.
//

import UIKit

class AccountSummaryViewController: UITableViewController {
    
    let games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol"
    ]
    
//    let tableView = UITableView()  //  instance created automatically
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension AccountSummaryViewController {
    
    private func setup() {
        
        setupTableView()
    }
    
    private func setupTableView() {
        
//        tableView.delegate = self  // automatically defined
//        tableView.dataSource = self // automatically defined
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tableView) now automatically loaded
   
        
        // Seems that UITableViewController automatically comes with layout constraints
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
}

extension AccountSummaryViewController {  //  Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return games.count
}

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row]
        return cell
    }
}

extension AccountSummaryViewController { // Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
    }
}
