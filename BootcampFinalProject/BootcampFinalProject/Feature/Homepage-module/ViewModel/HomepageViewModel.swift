//
//  HomepageViewModel.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import Foundation

protocol HomepageViewModelDelegate {
    var view: HomepageViewControllerDelegate? { get set}
    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func cellForItemAt(at indexPath: IndexPath) -> Game?
    func didSelectItemAt(at indexPath: IndexPath)
    func updateSearchResults(text: String?)
    func getGameID() -> Int?
    
}

final class HomepageViewModel: HomepageViewModelDelegate {
    //MARK: - Property
    weak var view: HomepageViewControllerDelegate?
    private var id: Int?
    private var mainGameList = [Game](){
        didSet{
            filteredGameList = mainGameList
        }
    }
    private var filteredGameList = [Game](){
        didSet{
            view?.collectionViewReloadData()
        }
    }
    
    //MARK: - Lifecycle
    func viewDidLoad() {
        view?.prepareCollectionView()
        view?.prepareSearchController()
        getAllGames()
    }
    
    //MARK: - CollectionViewDataSourceMethods
    func numberOfItemsInSection() -> Int {
        filteredGameList.count
    }
    
    func cellForItemAt(at indexPath: IndexPath) -> Game? {
        filteredGameList[indexPath.row]
    }
    
    //MARK: - CollectionViewDelegateMethods
    func didSelectItemAt(at indexPath: IndexPath) {
        self.id = filteredGameList[indexPath.row].id
        view?.performSegue(identifier: "homepageToDetail")
    }
    
    //MARK: - SearchBar Method
    func updateSearchResults(text: String?) {
        if text.isNilOrEmpty {
            filteredGameList = mainGameList
        
        } else {
            filteredGameList = mainGameList.filter({ $0.name.uppercased().contains(text!.uppercased())})
        }
        
    }
    
    func getGameID() -> Int? {
        self.id
    }
    
    //MARK: - Private Methods
    private func getAllGames(){
        NetworkManager.shared.getAllGames(queryItems: []) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let games):
                self.mainGameList = games
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
