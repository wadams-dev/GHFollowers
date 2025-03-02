//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by William Adams on 3/1/25.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
}
