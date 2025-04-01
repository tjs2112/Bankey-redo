//
//  AccountSummaryViewController.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/14/25.
//

import UIKit

class AccountSummaryViewController: UITableViewController {
    
    // Request Models
    var profile: Profile?
    var accounts: [Account] = []
    
    // View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeText: "Welcome", name: "", date: Date())
    var accountCellViewModels: [ViewModel] = []
    
    // Components
    var headerView = AccountSummaryHeaderView(frame: .zero)
    
    // Networking
    var profileManager: ProfileManageable = ProfileManager()
    
    // Error Alert
    lazy var errorAlert: UIAlertController = {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    var isLoaded = false
    
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        
        let barButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
//    let tableView = UITableView()  //  instance created automatically
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension AccountSummaryViewController {
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .primaryActionTriggered)
        self.refreshControl = refreshControl
    }
    
    private func setup() {
        
        setupTableView()
        setupTableHeaderView()
        configureNavigationBar()
        setupRefreshControl()
        setupSkeletons()
        configureTableCells(with: accounts)

        fetchData()
    }
    
    private func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setupTableView() {
        
//        tableView.delegate = self  // automatically defined
//        tableView.dataSource = self // automatically defined
        
        tableView.backgroundColor = appColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()  // Strange but actually hides the footer
        
//        view.addSubview(tableView) // now automatically loaded
   
        
        // Seems that UITableViewController automatically comes with layout constraints
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
    
    private func setupTableHeaderView() {
        
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
        
    }
}

extension AccountSummaryViewController {  //  Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Accounts AccountCellViewModels count\(accountCellViewModels.count)")
        return accountCellViewModels.count
}

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accountCellViewModels.isEmpty else {return UITableViewCell()}
        
        
        if isLoaded {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            cell.configure(with: accountCellViewModels[indexPath.row])
            return cell
        }
        
        print("CellForRowAt loaded is false")
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
        cell.configure(with: accountCellViewModels[indexPath.row])
        return cell
    }
}

extension AccountSummaryViewController { // Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
    }
}

// MARK: - Networking

extension AccountSummaryViewController {
    
    private func fetchData() {
        
        let group = DispatchGroup()
        let randomProfileID = String(Int.random(in: 1..<4))  // just for testing UIRefreshControl
        
        fetchProfile(group: group, userID: randomProfileID)
        fetchAccounts(group: group, userID: randomProfileID)
        
        group.notify(queue: .main) {
            self.reloadView()
        }
    }
    
    private func fetchProfile(group: DispatchGroup, userID: String) {
        
        group.enter()
        profileManager.fetchProfile(forUserID: userID) { result in
            
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                let titleAndMessage = self.titleAndMessage(for: error)
                self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
            }
            group.leave()
        }
    }
    
    private func fetchAccounts(group: DispatchGroup, userID: String) {
        
        group.enter()
        fetchAccounts(forUserID: userID) { result in
            
            switch result {
            case .success(let accounts):
                print("accounts success")
                self.accounts = accounts
            case .failure(let error):
                let titleAndMessage = self.titleAndMessage(for: error)
                
                self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
            }
            group.leave()
        }
    }
    
    private func reloadView() {
        
        self.tableView.refreshControl?.endRefreshing()
        self.isLoaded = true
        if let profile = self.profile {
            self.configureTableHeaderView(with: profile)
        }
        self.configureTableCells(with: self.accounts)
        self.tableView.reloadData()
    }
    
    private func titleAndMessage(for error: NetworkError) -> (String, String) {
        
        let title: String
        let message: String
        
        switch error {
        case .serverError:
            title = "Server Error"
            message = "There was a Server Error.  Please try again later."
        case .decodingError:
            title = "Decoding Error"
            message = "There was an error decoding data received.  Please contact the helpdesk with error."
         }
        return (title, message)
    }
    
    private func showErrorAlert(title: String, message: String) {
        
        errorAlert.title = title
        errorAlert.message = message
        
        self.present(errorAlert, animated: true)
    }
    
    
    
    private func configureTableHeaderView(with profile: Profile) {
        
        let vm = AccountSummaryHeaderView.ViewModel(welcomeText: "Good Morning,", name: profile.firstName, date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts:[Account]) {
        
        accountCellViewModels = accounts.map {
            ViewModel(
                accountType: $0.type,
                accountName: $0.name,
                balance: $0.amount
            )
        }
    }
    
    private func setupSkeletons() {
        
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        
        configureTableCells(with: accounts)
    }
    
}

// MARK: - Actions

extension AccountSummaryViewController {
    
    @objc func logoutTapped() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshData() {
        
        print("Refresh control hooked up")
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        
        print("refresh called")
        profile = nil
        accounts = []
        isLoaded = false
    }
}

// MARK: - Unit Testing

extension AccountSummaryViewController {
    
    //  this is a way to allow unit testing of a private function without making the private function Public.  Easy to comment out and turn off if needed
    func titleAndMessageForTesting(for error: NetworkError) -> (String, String) {
        
        return titleAndMessage(for: error)
    }
    
    func forceFetchProfile() {
        
        fetchProfile(group: DispatchGroup(), userID: "1")
    }
}

