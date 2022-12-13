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
}

final class HomepageViewModel: HomepageViewModelDelegate {
    //MARK: - Property
    weak var view: HomepageViewControllerDelegate?
    var gameList = [Game]() {
        didSet{
            view?.collectionViewReloadData()
        }
    }
    
    //MARK: - Lifecycle
    func viewDidLoad() {
        view?.prepareCollectionView()
        getAllGames()
    }
    
    //MARK: - CollectionViewDataSourceMethods
    func numberOfItemsInSection() -> Int {
        gameList.count
    }
    
    func cellForItemAt(at indexPath: IndexPath) -> Game? {
        gameList[indexPath.row]
    }
    
    //MARK: - Private Methods
    private func getAllGames(){
        NetworkManager.shared.getAllGames(queryItems: []) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let games):
                self.gameList = games
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
