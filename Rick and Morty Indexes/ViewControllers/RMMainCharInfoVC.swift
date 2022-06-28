//
//  RMMainCharInfoVC.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 26/6/22.
//

import UIKit

class RMMainCharInfoVC: UIViewController {
    
    let avatarImageView = RMAvatarImageView(frame: .zero)
    let nameLabel = RMTitleLabel(textAlignment: .left, fontSize: 25)
    let genderLabel = RMSecondaryTitleLabel(fontSize: 20)
    let speciesLabel = RMTitleLabel(textAlignment: .left, fontSize: 20)
    let statusLabel = RMSecondaryTitleLabel(fontSize: 20)
    let originNameLabel = RMTitleLabel(textAlignment: .center, fontSize: 24)
    let locationNameLabel = RMTitleLabel(textAlignment: .center, fontSize: 24)
    let charCreatedAtLabel = RMSecondaryTitleLabel(fontSize: 18)
    
    var itemViews: [UIView] = []
    var charInfo: RMCharacterInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addsubviews()
        layoutUI()
        configureElements()
    }
    
    init(mainCharInfo: RMCharacterInfo) {
        super.init(nibName: nil, bundle: nil)
        self.charInfo = mainCharInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureElements() {
        avatarImageView.getImage(from: charInfo.image)
        nameLabel.text = charInfo.name
        genderLabel.text = charInfo.gender
        statusLabel.text = charInfo.status
    }
    
    
    func addsubviews() {
        itemViews = [avatarImageView, nameLabel, genderLabel, speciesLabel, statusLabel, originNameLabel, locationNameLabel, charCreatedAtLabel ]
        
        for itemView in itemViews {
            view.addSubview(itemView)
        }
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 130),
            avatarImageView.heightAnchor.constraint(equalToConstant: 130),
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            genderLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            genderLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            genderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            genderLabel.heightAnchor.constraint(equalToConstant: padding + 10),
            
            speciesLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            speciesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            speciesLabel.widthAnchor.constraint(equalToConstant: 300),
            speciesLabel.heightAnchor.constraint(equalToConstant: padding + 10),
            
            statusLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor, constant: padding),
            statusLabel.centerYAnchor.constraint(equalTo: speciesLabel.centerYAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            statusLabel.heightAnchor.constraint(equalToConstant: padding + 10)
        ])
    }
    
    
}
