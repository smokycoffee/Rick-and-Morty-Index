//
//  RMCharLocationInfoHeaderVC.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 7/7/22.
//

import UIKit

class RMCharLocationInfoHeaderVC: UIViewController {
    
    let nameLabel = RMTitleLabel(textAlignment: .center, fontSize: 20)
    let typeOfPlaceLabel = RMSecondaryTitleLabel(fontSize: 18, textAlignment: .center)
    let dimensionLabel = RMSecondaryTitleLabel(fontSize: 18, textAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    
    init(locationInfo: RmLocationInfo, nameLabels: String) {
        super.init(nibName: nil, bundle: nil)

        nameLabel.text = nameLabels
        typeOfPlaceLabel.text = "Type: \(locationInfo.type)"
        dimensionLabel.text = "Dimension: \(locationInfo.dimension)"
    }
//    "Last Seen: \(locationInfo.name)"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        view.addSubview(nameLabel)
        view.addSubview(typeOfPlaceLabel)
        view.addSubview(dimensionLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        typeOfPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        dimensionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dimensionLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 35),
            
            typeOfPlaceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            typeOfPlaceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            typeOfPlaceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            typeOfPlaceLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dimensionLabel.topAnchor.constraint(equalTo: typeOfPlaceLabel.bottomAnchor),
            dimensionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimensionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimensionLabel.heightAnchor.constraint(equalToConstant: 45)
            
        ])
    }
}
