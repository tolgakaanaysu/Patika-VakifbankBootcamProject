//
//  FavoriteListViewModel.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 15.12.2022.
//

import Foundation

protocol FavoriListViewModelInterface {
    var view: FavoriteListVCDelegate? { get set}
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowItem(at indexPath: IndexPath) -> FavoriteGame
    func didSelectRowAt(at indexPath: IndexPath)
    func deleteButtonAction(at indexPath: IndexPath)
   
}

final class FavoriListViewModel: FavoriListViewModelInterface {
    //MARK: - Property
    var view: FavoriteListVCDelegate?
    var selectedFavoriteGame: FavoriteGame?
    var favoriteGames = [FavoriteGame]() {
        didSet{
            view?.tableViewReloadData()
            debugPrint(favoriteGames.count)
        }
    }
    
    //MARK: - Lifecycle
    func viewDidLoad(){
        view?.prepareTableView()
        getFavoriteGames()
        favoriteStatusWillChange()
    }
 
    //MARK: - IBAction methods
    func deleteButtonAction(at indexPath: IndexPath) {
        let favoriGame = favoriteGames[indexPath.row]
        CoreDataFavoriGameClient.shared.deleteFavoriGame(id: favoriGame.id!) { [weak self] result in
            switch result {
            case .success(let success):
                self?.view?.showSuccesMessage(message: success.message)
                self?.view?.tableViewReloadData()
            case .failure(let error):
                self?.view?.showError(message: error.message)
            }
        }
    }
    
    //MARK: -TableViewDataSourceMethods
    func numberOfRowsInSection() -> Int {
        favoriteGames.count
    }
    
    func cellForRowItem(at indexPath: IndexPath) -> FavoriteGame {
        favoriteGames[indexPath.row]
    }
    
    //MARK: - TableViewDelegeteMethods
    func didSelectRowAt(at indexPath: IndexPath) {
        selectedFavoriteGame = favoriteGames[indexPath.row]
        guard selectedFavoriteGame != nil else { return }
        view?.performSegue(identifier: "favoriteListToDetail")
    }
    
    //MARK: - Private methods
    @objc private func getFavoriteGames(){
        CoreDataFavoriGameClient.shared.getAllFavoriteGame { [weak self] result in
            switch result {
            case .success(let favoriteGames):
                self?.favoriteGames = favoriteGames
            case .failure(let error):
                self?.view?.showError(message: error.message)
            }
        }
    }
    
    private func favoriteStatusWillChange(){
        //FIXME: Manage notify class
        NotificationCenter.default.addObserver(self, selector: #selector(getFavoriteGames), name: NSNotification.Name("changeFavoriteStatus"), object: nil)
    }
}
