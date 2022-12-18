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
    func cellForRowItem(at index: Int) -> FavoriteGame
    func didSelectRowAt(at index: Int)
    func deleteButtonAction(at index: Int)
}

final class FavoriListViewModel: FavoriListViewModelInterface {
    //MARK: - Property
    var view: FavoriteListVCDelegate?
    var selectedFavoriteGame: FavoriteGame?
    private var favoriteGames = [FavoriteGame]() {
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
        favoriteGameDetailDataNotFound()
       
    }
 
    //MARK: - IBAction methods
    func deleteButtonAction(at index: Int) {
        let favoriGame = favoriteGames[index]
        CoreDataFavoriGameClient.shared.deleteFavoriGame(id: favoriGame.id!) { [weak self] result in
            switch result {
            case .success(let success):
                self?.view?.showSuccessAlert(message: success.message)
                self?.getFavoriteGames()
            case .failure(let error):
                self?.view?.showErrorAlert(message: error.message)
            }
        }
    }
    
    //MARK: -TableViewDataSourceMethods
    func numberOfRowsInSection() -> Int {
        favoriteGames.count
    }
    
    func cellForRowItem(at index: Int) -> FavoriteGame {
        favoriteGames[index]
    }
    
    //MARK: - TableViewDelegeteMethods
    func didSelectRowAt(at index: Int) {
        selectedFavoriteGame = favoriteGames[index]
        guard selectedFavoriteGame != nil else { return }
        view?.performSegue(identifier: Identifiers.favoriteListVCToDetailsVC)
    }
    
    //MARK: - Private methods
    @objc  func getFavoriteGames(){
        CoreDataFavoriGameClient.shared.getAllFavoriteGame { [weak self] result in
            switch result {
            case .success(let favoriteGames):
                self?.favoriteGames = favoriteGames
            case .failure(let error):
                self?.view?.showErrorAlert(message: error.message)
            }
        }
    }
    
    private func favoriteStatusWillChange(){
        let name = CommunicationMessage.changedFavoriteStatus.rawValue
        CommunicationBetweenModules.shared.observe(observer: self,
                                                   name: name,
                                                   selector: #selector(getFavoriteGames))
    }
    
    private func favoriteGameDetailDataNotFound(){
        let name = CommunicationMessage.favoriteGameDetailDataNotFound.rawValue
        CommunicationBetweenModules.shared.observe(observer: self, name: name, selector: #selector(showError))
    }
    
    @objc private func showError(){
        view?.showErrorAlert(message: LocalizableConstant.dataParseError)
    }
}
