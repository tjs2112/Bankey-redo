//
//  AccountSummaryViewController.swift
//  Bankey Re-do
//
//  Created by Todd Smith on 3/14/25.
//

import UIKit

class AccountSummaryViewController: UITableViewController {
    
    var accounts: [AccountSummaryCell.ViewModel] = []
    
//    let tableView = UITableView()  //  instance created automatically
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension AccountSummaryViewController {
    
    private func setup() {
        
        setupTableView()
        setupTableHeaderView()
        fetchData()
    }
    
    private func setupTableView() {
        
//        tableView.delegate = self  // automatically defined
//        tableView.dataSource = self // automatically defined
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()  // Strange but actually hides the footer
        
//        view.addSubview(tableView) now automatically loaded
   
        
        // Seems that UITableViewController automatically comes with layout constraints
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
    
    private func setupTableHeaderView() {
        let header = AccountSummaryHeaderView(frame: .zero)
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
        
    }
}

extension AccountSummaryViewController {  //  Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return accounts.count
}

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accounts.isEmpty else {return UITableViewCell()}
         
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        cell.configure(with: accounts[indexPath.row])
        return cell
    }
}

extension AccountSummaryViewController { // Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
    }
}
extension AccountSummaryViewController {
    
    private func fetchData() {
        
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings")
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Visa Avion Card")
        let investment = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver")
        
        accounts.append(savings)
        accounts.append(visa)
        accounts.append(investment)
        
            
            
    }
}
