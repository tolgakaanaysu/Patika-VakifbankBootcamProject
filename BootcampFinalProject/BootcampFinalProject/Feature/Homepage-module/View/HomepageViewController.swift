//
//  HomepageViewController.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import UIKit

protocol HomepageViewControllerDelegate: AnyObject,SeguePerformable {
    func prepareCollectionView()
    func prepareSearchController()
    func collectionViewReloadData()
}

final class HomepageViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var gameCollectionView: UICollectionView!
    
    //MARK: - Property
    private lazy var viewModel: HomepageViewModelDelegate = HomepageViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        title = "Popüler Games"
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

//MARK: - CollectionViewDataSource
extension HomepageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier ,for: indexPath) as? GameCollectionViewCell else {
            print("xib not found")
            return .init()
        }
        guard let game = viewModel.cellForItemAt(at: indexPath) else { return .init() }
        
        cell.configureCell(with: game)
        return cell
    }
}

//MARK: - HomepageViewControllerDelegate
extension HomepageViewController: HomepageViewControllerDelegate, UICollectionViewDelegateFlowLayout {
    func prepareCollectionView() {
        gameCollectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionViewConfig()
        gameCollectionView.backgroundColor = .systemGray3
        gameCollectionView.dataSource = self
        gameCollectionView.register(GameCollectionViewCell.nib, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        
    }
    
    func prepareSearchController(){
        let search = UISearchController(searchResultsController: nil)
                search.searchResultsUpdater = self
                search.searchBar.placeholder = "Type something to search"
                navigationItem.searchController = search
    }
    
    private func collectionViewConfig(){
          let flowLayout = UICollectionViewFlowLayout()
          flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
          flowLayout.minimumInteritemSpacing = 10
          flowLayout.minimumLineSpacing = 20
          let genislik = gameCollectionView.frame.size.width
          let hucre_genislik = (genislik - 30) / 2
        flowLayout.itemSize = CGSize(width: hucre_genislik, height: hucre_genislik * 1.4)
        gameCollectionView.collectionViewLayout = flowLayout
      }
    
    func collectionViewReloadData() {
        gameCollectionView.reloadData()
    }
}

extension HomepageViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        viewModel.updateSearchResults(text: text)
    }
}
