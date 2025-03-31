//
//  SkeletonCell.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/28/25.
//

import UIKit

extension SkeletonCell: SkeletonLoadable {}

class SkeletonCell: UITableViewCell {
    
//    let viewModel: ViewModel? = nil
        
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    // Gradients
    let typeLayer = CAGradientLayer()
    let nameLayer = CAGradientLayer()
    let balanceLayer = CAGradientLayer()
    let balanceAmountLayer = CAGradientLayer()
    
    static let reuseID = "SkeletonCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupLayers()
        setupAnimations()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // IMPORTANT WITHOUT Overiding this method the gradients do not appear.  CALayers do not automatically move and resize with their corresponding UIViews so this must be handled by overriding layourSubviews.
    override func layoutSubviews() {
        super.layoutSubviews()
        
        typeLayer.frame = typeLabel.bounds
        typeLayer.bounds.size.width += 5
        typeLayer.cornerRadius = typeLabel.bounds.height / 2
        
        nameLayer.frame = nameLabel.bounds
        nameLayer.cornerRadius = nameLabel.bounds.height / 2
        
        balanceLayer.frame = balanceLabel.bounds
        balanceLayer.cornerRadius = balanceLabel.bounds.height / 2
        
        balanceAmountLayer.frame = balanceAmountLabel.bounds
        balanceAmountLayer.cornerRadius = balanceAmountLabel.bounds.height / 2
    }
}

extension SkeletonCell {
    private func setup() {
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.text = "-Account Name-"
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 8
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.adjustsFontSizeToFitWidth = true

        balanceLabel.textAlignment = .right
        balanceLabel.text = "Some balance"
        
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
//        balanceLabel.adjustsFontForContentSizeCategory = true
        balanceAmountLabel.textAlignment = .right
        balanceAmountLabel.attributedText = NSAttributedString()
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.tintColor = appColor
         
    }
    
    private func setupLayers() {
        
        typeLayer.startPoint = CGPoint(x: 0, y: 0.5)
        typeLayer.endPoint = CGPoint(x: 1, y: 0.5)
        typeLabel.layer.addSublayer(typeLayer)
        
        nameLayer.startPoint = CGPoint(x: 0, y: 0.5)
        nameLayer.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabel.layer.addSublayer(nameLayer)
        
        balanceLayer.startPoint = CGPoint(x: 0, y: 0.5)
        balanceLayer.endPoint = CGPoint(x: 1, y: 0.5)
        balanceLabel.layer.addSublayer(balanceLayer)
        
        balanceAmountLayer.startPoint = CGPoint(x: 0, y: 0.5)
        balanceAmountLayer.endPoint = CGPoint(x: 1, y: 0.5)
        balanceAmountLabel.layer.addSublayer(balanceAmountLayer)
        
    }
    
    private func setupAnimations() {
        
        let typeGroup = makeAnimationGroup()
        typeGroup.beginTime = 0.0
        typeLayer.add(typeGroup, forKey: "backgroundColor")
        
        let nameGroup = makeAnimationGroup(previousGroup: typeGroup)
        nameLayer.add(nameGroup, forKey: "backgroundColor")
        
        let balanceGroup = makeAnimationGroup(previousGroup: nameGroup)
        balanceLayer.add(balanceGroup, forKey: "backgroundColor")
        
        let balanceAmountGroup = makeAnimationGroup(previousGroup: balanceGroup)
        balanceAmountLayer.add(balanceAmountGroup, forKey: "backgroundColor")
    }
    
    private func layout() {
        
        contentView.addSubview(typeLabel)  //  important.  Add to contentView for table Cells, not just view
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            underlineView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.topAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 4),
            chevronImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
//    private func makeFormattedBalance(dollars: String, cents: String) -> NSAttributedString {
//
//        let dollarSignAttriutes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
//        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
//        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
//
//        let rootString = NSMutableAttributedString(string: "$", attributes: dollarAttributes)
//        rootString.append(NSAttributedString(string: dollars, attributes: dollarAttributes))
//        rootString.append(NSAttributedString(string: cents, attributes: centAttributes))
//
//        return rootString
//    }
}

extension SkeletonCell {
    
    func configure(with vm: ViewModel) {
        print(vm)
        
        typeLabel.text = vm.accountType.rawValue
                
        switch vm.accountType {
        case .Banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Current Balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Current Balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
        
        nameLabel.text = vm.accountName
        
        balanceAmountLabel.attributedText = vm.balanceAttributedString
        
    }
}
