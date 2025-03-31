//
//  AccountSummaryHeaderView.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/14/25.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let shakeyBell = ShakeyBellView()
    
    struct ViewModel {
        let welcomeText: String
        let name: String
        let date: Date
        
        var dateFormatted: String {
            return date.monthDayYearString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit() {
        
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        shakeyBell.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakeyBell)
        NSLayoutConstraint.activate([
            shakeyBell.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakeyBell.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    func configure(viewModel: ViewModel) {
        
        welcomeLabel.text = viewModel.welcomeText
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.dateFormatted
    }
    
    
}
