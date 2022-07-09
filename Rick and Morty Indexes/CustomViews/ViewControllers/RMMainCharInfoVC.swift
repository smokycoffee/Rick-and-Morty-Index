//
//  RMMainCharInfoVC.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 26/6/22.
//

import UIKit

class RMMainCharInfoVC: UIViewController {
    
    let avatarImageView = RMAvatarImageView(frame: .zero)
    let nameLabel = RMTitleLabel(textAlignment: .left, fontSize: 20)
    let genderLabel = RMSecondaryTitleLabel(fontSize: 20, textAlignment: .natural)
    let speciesLabel = RMTitleLabel(textAlignment: .left, fontSize: 18)
    let statusLabel = RMSecondaryTitleLabel(fontSize: 20, textAlignment: .left)
    let charCreatedAtLabel = RMSecondaryTitleLabel(fontSize: 18, textAlignment: .center)
    
    var itemViews: [UIView] = []
    var charInfo: RMCharacterInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addsubviews()
        layoutUI()
        configureUIElements()
        overrideConfigures()
    }
    
    init(mainCharInfo: RMCharacterInfo) {
        super.init(nibName: nil, bundle: nil)
        self.charInfo = mainCharInfo
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUIElements() {
        avatarImageView.getImage(from: charInfo.image)
        nameLabel.text = charInfo.name
        genderLabel.text = "Gender: \(charInfo.gender)"
        statusLabel.text = charInfo.status
        speciesLabel.text = "Species: \(charInfo.species)"
        
        //        🟢 🔴
    }
    
    
    func overrideConfigures() {
        avatarImageView.layer.cornerRadius = 5
        speciesLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium) //override
        nameLabel.numberOfLines = 2
    }
    
    
    func addsubviews() {
        itemViews = [avatarImageView, nameLabel, genderLabel, speciesLabel, statusLabel, charCreatedAtLabel ]
        
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
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            genderLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            genderLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            genderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            genderLabel.heightAnchor.constraint(equalToConstant: padding + 10),
            
            speciesLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            speciesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            speciesLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 ),
            speciesLabel.heightAnchor.constraint(equalToConstant: padding + 10),
            
            statusLabel.centerYAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 35),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            statusLabel.heightAnchor.constraint(equalToConstant: padding + 10)
        ])
    }
    
    
}
