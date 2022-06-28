//
//  CharInfoVC.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 25/6/22.
//

import UIKit

class CharInfoVC: UIViewController {
    
    var id: Int!
    
    var charinfo: RMCharacterInfo!
    
    let infoView = UIView()
//    let mainCharInfo = RMMainCharInfoVC(mainCharInfo: RMCharacterInfo)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemIndigo
        closeButton()
        getCharInfo(for: id)
        configureInfoView()
    }
    
    
    func getCharInfo(for id: Int) {
        NetworkManager.shared.getCharInfo(for: id) { result in
            switch result {
                
            case .success(let charInfo):
                print(charInfo)
                DispatchQueue.main.async {
                    self.add(childVC: RMMainCharInfoVC(mainCharInfo: charInfo), to: self.infoView)
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
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    func configureInfoView() {
        view.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.backgroundColor = .systemTeal
                
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
}
