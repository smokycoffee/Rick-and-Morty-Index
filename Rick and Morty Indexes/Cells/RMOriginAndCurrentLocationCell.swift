//
//  RMOriginAndCurrentLocationCell.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 6/7/22.
//

import UIKit

class RMOriginAndCurrentLocationCell: UICollectionViewCell {
    static let reuseID = "LocationIndexCell" // identifier for cell ID
    
    var avatarImageView = RMAvatarImageView(frame: .zero)
    var nameLabel = RMTitleLabel(textAlignment: .center, fontSize: 20)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(index: RMCharLocationCharInfo) {
        nameLabel.text = index.name
        avatarImageView.getImage(from: index.image)
    }
    
    private func configure() {
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        let padding: CGFloat = 8
        
        nameLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
}
