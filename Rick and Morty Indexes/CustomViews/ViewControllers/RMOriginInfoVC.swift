//
//  OriginViewController.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 30/6/22.
//

import UIKit

enum OriginSection {
    case main
}

class RMOriginInfoVC: UIViewController {
    
    
    var charInfo: RMCharacterInfo!
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<OriginSection, RMCharLocationCharInfo>!
    
    var titleLabel = RMTitleLabel(textAlignment: .center, fontSize: 30)
    
    var charOriginCharInfo: [RMCharLocationCharInfo] = []
    var arrayofCharacters = [String]()
    
    let originInfoView = UIView()
    let locationInfoView = UIView()
    let collectionViewContentView = UIView()
    
    
    init(charInfo: RMCharacterInfo) {
        self.charInfo = charInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocationInfo(url: charInfo.location.url)
        getOriginLocationInfo(url: charInfo.origin.url)
        configureCollectionView()
        configureDataSource()
        configureUILayout()
    }
    
    
    func getLocationInfo(url: String) {
        NetworkManager.shared.getLocationInfo(get: url) { [weak self] result in
            guard let self = self else {return}

            switch result {
            case .success(let locationInfo):
                DispatchQueue.main.async {
                    self.add(childVC: RMCharLocationInfoHeaderVC(locationInfo: locationInfo, nameLabels: "Last Seen: \(locationInfo.name)"), to: self.locationInfoView)
                }
//                print(locationInfo.residents)
                for item in locationInfo.residents {
                    NetworkManager.shared.getOriginAndCurrentLocation(for: item) { result in
                        switch result {
                        case .success(let locationCharInfo):
                            DispatchQueue.main.async {
                                self.charOriginCharInfo.append(locationCharInfo)
                                self.updateData(on: self.charOriginCharInfo)
                            }
                        case .failure(let error):
                            print(error.rawValue)
                        }
                    }
                }
            case .failure(let error):
                print((error.rawValue))
            }
        }
    }
    
    func getOriginLocationInfo(url: String) {
        NetworkManager.shared.getLocationInfo(get: url) { [weak self] result in
            guard let self = self else {return}
            
            switch result {

            case .success(let originInfo):
                DispatchQueue.main.async {
                    self.add(childVC: RMCharLocationInfoHeaderVC(locationInfo: originInfo, nameLabels: "Origin: \(originInfo.name)"), to: self.originInfoView)
                }
            case .failure(let error):
                print(error.rawValue)
                DispatchQueue.main.async {
                    self.originInfoView.backgroundColor = UIColor(red: 34/255, green: 42/255, blue: 104/255, alpha: 1)
                }
            }
        }
    }
    
    
    func configureUILayout() {
        view.addSubview(originInfoView)
        view.addSubview(locationInfoView)
        view.addSubview(collectionViewContentView)
        
        originInfoView.translatesAutoresizingMaskIntoConstraints = false
        locationInfoView.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContentView.translatesAutoresizingMaskIntoConstraints = false
        
        locationInfoView.backgroundColor = UIColor(red: 101/255, green: 69/255, blue: 151/255, alpha: 1)
        locationInfoView.layer.cornerRadius = 20
        originInfoView.backgroundColor = UIColor(red: 101/255, green: 69/255, blue: 151/255, alpha: 1)
        originInfoView.layer.cornerRadius = 20
        
//        UIColor(red: 87/255, green: 74/2555, blue: 226/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            locationInfoView.topAnchor.constraint(equalTo: view.topAnchor),
            locationInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationInfoView.heightAnchor.constraint(equalToConstant: 110),
            
            collectionViewContentView.topAnchor.constraint(equalTo: locationInfoView.bottomAnchor),
            collectionViewContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            originInfoView.topAnchor.constraint(equalTo: collectionViewContentView.bottomAnchor),
            originInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            originInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            originInfoView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: getCompositionalLyaout())
        collectionViewContentView.addSubview(collectionView)
//        collectionView.backgroundColor = .systemIndigo
        collectionView.backgroundColor = UIColor(red: 34/255, green: 42/255, blue: 104/255, alpha: 1)
        collectionView.register(RMOriginAndCurrentLocationCell.self, forCellWithReuseIdentifier: RMOriginAndCurrentLocationCell.reuseID)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: collectionViewContentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: collectionViewContentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: collectionViewContentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionViewContentView.bottomAnchor)
        ])

    }
        
    
    func getCompositionalLyaout() -> UICollectionViewCompositionalLayout {
        
        //--------- Carousel ---------// .fractionalWidth(1/2)
        
        let carouselItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(230)))
        carouselItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), subitems: [carouselItem])
        
        let carouselItemTwo = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(230)))
        carouselItemTwo.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), subitems: [carouselItemTwo])
        
        let carouselGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)), subitems: [group1, group2])
        
        let carouselSection = NSCollectionLayoutSection(group: carouselGroup)
        carouselSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        carouselSection.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.7
                let maxScale: CGFloat = 1.1
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        let layout = UICollectionViewCompositionalLayout(section: carouselSection)
        return layout
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<OriginSection, RMCharLocationCharInfo>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMOriginAndCurrentLocationCell.reuseID, for: indexPath) as! RMOriginAndCurrentLocationCell
            cell.backgroundColor = UIColor(red: 171/255, green: 129/255, blue: 205/255, alpha: 1)
//            cell.backgroundColor = UIColor(red: 34/255, green: 42/255, blue: 104/255, alpha: 1)
            cell.set(index: itemIdentifier)
            cell.layer.cornerRadius = 10
            return cell
        })
    }
    
    
    func updateData(on locationCharInfo: [RMCharLocationCharInfo]) {
        var snapshot = NSDiffableDataSourceSnapshot<OriginSection, RMCharLocationCharInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(locationCharInfo)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}


extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1),
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.4...1),
                       alpha: 1)
    }
}
