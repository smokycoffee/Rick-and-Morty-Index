//
//  RMIndexCell.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 23/6/22.
//

import UIKit

class RMIndexCell: UICollectionViewCell {
    static let reuseID = "IndexCell" // identifier for cell ID
    
    var avatarImageView = RMAvatarImageView(frame: .zero)
    var nameLabel = RMTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(index: ArrayOfRickAndMorty.Results) {
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
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 18)
//
//            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
//            avatarImageView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
}
