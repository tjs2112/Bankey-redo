//
//  ShakeyBellView.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/23/25.
//

import UIKit

class ShakeyBellView: UIView {
    
    let imageView = UIImageView()
    
    let bellBadgeButton = UIButton()
    let bellBadgeHeight = CGFloat(16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

extension ShakeyBellView {
    
    private func setup() {
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_: )))
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }
    
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        
        bellBadgeButton.translatesAutoresizingMaskIntoConstraints = false
        bellBadgeButton.backgroundColor = .systemRed
        bellBadgeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bellBadgeButton.setTitle("9", for: .normal)
        bellBadgeButton.setTitleColor(.white, for: .normal)
        bellBadgeButton.layer.cornerRadius = bellBadgeHeight / 2
        
    }
    
    private func layout() {
        
        addSubview(imageView)
        addSubview(bellBadgeButton)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            bellBadgeButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            bellBadgeButton.widthAnchor.constraint(equalToConstant: 16),
            bellBadgeButton.heightAnchor.constraint(equalToConstant: 16),
            bellBadgeButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -9)
        ])
        
    }
}

// MARK: - Actions

extension ShakeyBellView {
    
    @objc private func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
        shakeWith(duration: 1.0, angle: .pi/8, yOffset: 0.0)
    }
    
    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        
        let numberOfFrames: Double = 6
        let frameDuration = Double(1 / numberOfFrames)
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 2, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 3, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 4, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 5, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform.identity
            }
        }, completion: nil
        )
    }
}

// https://www.hackingwithswift.com/example-code/calayer/how-to-change-a-views-anchor-point-without-moving-it
extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        
        print("Before: \(newPoint)")
        newPoint = newPoint.applying(transform)
        print("After: \(newPoint)")
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        print(position)
        
        position.x -= oldPoint.x
        print("Position x Before: \(position.x)")
        position.x += newPoint.x
        print("Position x After: \(position.x)")
        
        position.y -= oldPoint.y
        print("Position y Before: \(position.y)")
        position.y += newPoint.y
        print("Position y After: \(position.y)")
        
        layer.position = position
        layer.anchorPoint = point

        
    }
}
