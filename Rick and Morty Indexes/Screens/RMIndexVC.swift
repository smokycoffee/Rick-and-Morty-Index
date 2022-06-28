//
//  RMIndexVC.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 23/6/22.
//

import UIKit

enum Section {
    case main
}

class RMIndexVC: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, ArrayOfRickAndMorty.Results>!
    
    var listOfIndexes: [ArrayOfRickAndMorty.Results] = []
    var page = 1
    var hasMoreIndex = true
    var isSearching = false
    var filteredCharacters: [ArrayOfRickAndMorty.Results] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barTintColor = UIColor.green
        //        view.backgroundColor = UIColor(red: 42 / 255.0, green: 142 / 255.0, blue: 147 / 255.0, alpha: 1.0)
        getArrayOfRIcksAndMortys(page: page)
        configureCollectionView()
        configureDataSource()
        configureSearchController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false

        title = "Rick and Morty Characters"

    }
    
    
    func getArrayOfRIcksAndMortys(page: Int) {
        
//        showLoading()
        NetworkManager.shared.getArrayOfRicksAndMortys(page: page) { [weak self] result in // weak self, capture list
            guard let self = self else {return} // memory leak
//            self.dismissLoading()
            switch result {
            
            case .success(let indexOfRM):
                if indexOfRM.results.count < 20 {self.hasMoreIndex = false}
                self.listOfIndexes.append(contentsOf: indexOfRM.results)
                self.updateData(on: self.listOfIndexes)
                
            case .failure(_):
                print("error, network call is not working")
            }
        }
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for Character"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    // MARK: CollectionView configuration
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColoumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(RMIndexCell.self, forCellWithReuseIdentifier: RMIndexCell.reuseID)
    }
    
    
    func createThreeColoumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
        return flowLayout
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ArrayOfRickAndMorty.Results>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMIndexCell.reuseID, for: indexPath) as! RMIndexCell
            
//            cell.backgroundColor = UIColor(red: 228/255, green: 167/255, blue: 136/255, alpha: 1) // skin colour,
//            cell.backgroundColor = UIColor(red: 232/255, green: 154/255, blue: 199/255, alpha: 1) // pink
            cell.backgroundColor = .systemIndigo
            cell.set(index: itemIdentifier)
            cell.layer.cornerRadius = 30
            
            return cell
        })
    }
    
    
    func updateData(on listOfIndexes: [ArrayOfRickAndMorty.Results]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ArrayOfRickAndMorty.Results>()
        snapshot.appendSections([.main])
        snapshot.appendItems(listOfIndexes)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: Delegates
extension RMIndexVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y // where youre scrolled at
        let contentHeight = scrollView.contentSize.height // is the height of the scrollview
        let height = scrollView.frame.size.height // height of screen
        
        if offSetY > contentHeight - height * 2 {
            guard hasMoreIndex, !isSearching else { return }
            page += 1
            getArrayOfRIcksAndMortys(page: page)
            updateData(on: listOfIndexes)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredCharacters : listOfIndexes
        let currentCharacter = activeArray[indexPath.item]
        let destinationVC = CharInfoVC()
        destinationVC.id = currentCharacter.id
        let navigationController = UINavigationController(rootViewController: destinationVC)
        present(navigationController, animated: true)
        
    }
}
    
extension RMIndexVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: listOfIndexes)
            isSearching = false
            return
        }
        isSearching = true
        filteredCharacters = listOfIndexes.filter { $0.name.lowercased().contains(filter.lowercased())}
        updateData(on: filteredCharacters)
    }

}
