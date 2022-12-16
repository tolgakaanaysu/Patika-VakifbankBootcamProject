//
//  HomepageViewController.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import UIKit

protocol HomepageViewControllerDelegate: AnyObject,SeguePerformable,Alert {
    func prepareComponents()
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
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
    //MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.id = viewModel.getGameID()
    }
    
    //MARK: - IBAction Methods
    @IBAction func menuButtonClicked(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Filter", message: "Please choise one item", preferredStyle: .actionSheet)
     
        
        let nameAction = createUIAlertAction(title: GameSortingType.name)
        actionSheet.addAction(nameAction)
        
        let ratingAction = createUIAlertAction(title: GameSortingType.rating)
        actionSheet.addAction(ratingAction)
        
        let updatedAction = createUIAlertAction(title: GameSortingType.updated)
        actionSheet.addAction(updatedAction)
        
        self.present(actionSheet, animated: true)
    }
    
    private func createUIAlertAction(title: String) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: .default) { [weak self] _ in
            self?.viewModel.getGameOrdering(with: title)
            self?.dismiss(animated: true)
        }
        return action
    }
    
    //MARK: - Private Methods
    private func prepareCollectionView() {
        gameCollectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionViewConfig()
        gameCollectionView.backgroundColor = .systemGray3
        gameCollectionView.dataSource = self
        gameCollectionView.delegate = self
        gameCollectionView.register(GameCollectionViewCell.nib, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
    }
    
    private func prepareSearchController(){
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Type something to search"
        search.searchBar.barTintColor = .systemIndigo
        search.searchBar.searchTextField.textColor = .darkGray
        search.searchBar.searchTextField.tokenBackgroundColor = .red
        search.searchBar.searchTextField.backgroundColor = .white
        search.searchBar.layer.borderWidth = 1
        search.searchBar.layer.borderColor = UIColor.systemIndigo.cgColor
        navigationItem.searchController = search
    }
    
   
    private func collectionViewConfig(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 20
        let width = gameCollectionView.frame.size.width
        let cellWidth = (width - 30) / 2
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.1)
        gameCollectionView.collectionViewLayout = flowLayout
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

//MARK: - UICollectionViewDelegate
extension HomepageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(at: indexPath)
        print("Clicked: \(indexPath.row)" )
    }
}

//MARK: - HomepageViewControllerDelegate
extension HomepageViewController: HomepageViewControllerDelegate {
    func prepareComponents() {
        view.backgroundColor = .systemGray3
        title = "Popüler Games"
        prepareCollectionView()
        prepareSearchController()
    }
    
    func collectionViewReloadData() {
        gameCollectionView.reloadData()
    }
}

//MARK: - UISearchResultsUpdating
extension HomepageViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        viewModel.updateSearchResults(text: text)
    }
}
