//
//  EntryVC.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 23/6/22.
//

import UIKit

class EntryVC: UIViewController {
    
    let placeholderImage = RMAvatarImageView(frame: .zero)
    let getIndexButton = RMButton(backgroundColour: .systemGreen, title: "Show Characters")
    let posingRickAndMorty = RMAvatarImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        view.backgroundColor = .systemBackground
        view.backgroundColor = UIColor(red: 151/255, green: 206/255, blue: 76/255, alpha: 1) // light green
        configureGetIndexesButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        configureEntryVC()
    }
    
    func configureEntryVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemGreen

    }
    
    
    func configureGetIndexesButton() {
        
        view.addSubview(placeholderImage)
        view.addSubview(getIndexButton)
        view.addSubview(posingRickAndMorty)
        
        placeholderImage.image = UIImage(named: "rick-and-morty-placeholder")
        posingRickAndMorty.image = UIImage(named: "rick-and-morty-pose")
        
        getIndexButton.addTarget(self, action: #selector(goRMIndexesVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            placeholderImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            placeholderImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderImage.heightAnchor.constraint(equalToConstant: 300),
            placeholderImage.widthAnchor.constraint(equalToConstant: 300),
            
            getIndexButton.topAnchor.constraint(equalTo: placeholderImage.bottomAnchor, constant: 100),
            getIndexButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            getIndexButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getIndexButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getIndexButton.heightAnchor.constraint(equalToConstant: 50),
            
            posingRickAndMorty.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            posingRickAndMorty.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            posingRickAndMorty.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50),
            posingRickAndMorty.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30)
        ])
    }
    
    
    @objc func goRMIndexesVC() {
        let destinationVC = RMIndexVC()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
