//
//  CharInfoVC.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 25/6/22.
//

import UIKit

class CharInfoVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var id: Int!
    let characterEndPoint = "character"
        
    let infoView = UIView()
    let originLocationSectionView = UIView()
    let currentLocationSectionView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemIndigo
        view.backgroundColor = UIColor(red: 34/255, green: 42/255, blue: 104/255, alpha: 1)
        closeButton()
        getCharInfo(get: characterEndPoint, for: id)
        configureScrollView()
        configureInfoView()
        configureSectionViews()
    }
    
    
    func getCharInfo(get: String ,for id: Int) {
        NetworkManager.shared.getCharInfo(get: get,for: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
                
            case .success(let charInfo):
            
                DispatchQueue.main.async {
                    self.add(childVC: RMMainCharInfoVC(mainCharInfo: charInfo), to: self.infoView)
                    self.add(childVC: RMOriginInfoVC(charInfo: charInfo), to: self.originLocationSectionView)
                }
                
            case .failure(let error):
                print(error.rawValue)
                
            }
        }
    }
   	
    
    func closeButton() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        closeButton.tintColor = .white
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
//    func add(childVC: UIViewController, to containerView: UIView) {
//        addChild(childVC)
//        containerView.addSubview(childVC.view)
//        childVC.view.frame = containerView.bounds
//        childVC.didMove(toParent: self)
//    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
            
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 900)
        ])
    }

    
    func configureInfoView() {
        contentView.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
//        infoView.backgroundColor = .systemTeal
                
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            infoView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureSectionViews() {
        contentView.addSubview(originLocationSectionView)
//        contentView.addSubview(currentLocationSectionView)
        
        originLocationSectionView.translatesAutoresizingMaskIntoConstraints = false
//        currentLocationSectionView.translatesAutoresizingMaskIntoConstraints = false
        
//        originLocationSectionView.backgroundColor = .blue
//        currentLocationSectionView.backgroundColor = .purple
        
        NSLayoutConstraint.activate([
            
            originLocationSectionView.topAnchor.constraint(equalTo: infoView.bottomAnchor),
            originLocationSectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            originLocationSectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            originLocationSectionView.heightAnchor.constraint(equalToConstant: 550)
//
//            currentLocationSectionView.topAnchor.constraint(equalTo: originLocationSectionView.bottomAnchor, constant: 8),
//            currentLocationSectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            currentLocationSectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            currentLocationSectionView.heightAnchor.constraint(equalToConstant: 220)
            
        ])
    }
    
    
}
