//
//  ProgressHeaderView.swift
//  Today
//
//  Created by hybrayhem.
//

import UIKit

class ProgressHeaderView: UICollectionReusableView { // Kept in reuse queue, when goes invisible on scroll, instead of being deleted like cells
    static var elementKind: String { UICollectionView.elementKindSectionHeader } // specifies type of this supplementary view
    
    var progress: CGFloat = 0 {
        didSet {
            updateHeightConstraint()
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }

    private let upperView = UIView(frame: .zero)
    private let lowerView = UIView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    private let aspectRatio = 0.5 // Constant
    private var heightConstraint: NSLayoutConstraint?
    
    required init?(coder: NSCoder) {
        fatalError("ProgressHeaderView, init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateHeightConstraint() // for rotation changes etc.
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 0.5 * containerView.bounds.width // make circle
    }
    
    private func updateHeightConstraint() {
        heightConstraint?.constant = progress * bounds.height
    }
    
    private func prepareSubviews() {
        // Add subviews
        containerView.addSubview(upperView)
        containerView.addSubview(lowerView)
        addSubview(containerView)
        
        upperView.translatesAutoresizingMaskIntoConstraints = false
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Container View
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: aspectRatio).isActive = true
        containerView.widthAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1.0).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
        
        // Upper View
        upperView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        upperView.bottomAnchor.constraint(equalTo: lowerView.topAnchor).isActive = true
        
        upperView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        upperView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        // Lower View
        lowerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        lowerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lowerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        heightConstraint = lowerView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
        
        // Colors
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        upperView.backgroundColor = .todayProgressUpperBackground
        lowerView.backgroundColor = .todayProgressLowerBackground
        
        // Animation
        // addWavingAnimation()
    }
    
    private func addWavingAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = -0.05
        animation.toValue = 0.05
        animation.duration = 0.5
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        containerView.layer.add(animation, forKey: "wavingAnimation")
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    let view = ProgressHeaderView()
//    view.progress = 0.5
//    
//    let layout = UICollectionViewFlowLayout()
//    layout.itemSize = CGSize(width: 100, height: 100)
//    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//
//    let vc = UICollectionViewController(collectionViewLayout: layout)
//    vc.view.addPinnedSubview(view)
//    let navc = UINavigationController(rootViewController: vc)
//    return navc
//}
