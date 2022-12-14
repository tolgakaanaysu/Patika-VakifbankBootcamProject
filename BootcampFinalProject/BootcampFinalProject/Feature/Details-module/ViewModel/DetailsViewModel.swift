//
//  DetailsViewModel.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 14.12.2022.
//

import Foundation

protocol DetailsViewModelDelegate {
    var view: DetailsViewControllerDelegate? { get set }
    var id: Int! { get set }
    func viewDidLoad()
    func favoriteButtonClicked()
}

final class DetailsViewModel: DetailsViewModelDelegate {
    //MARK: - Property
    var view: DetailsViewControllerDelegate?
    var id: Int!
    private var gameIsFavorite: Bool = false
    
    //MARK: - Lifecycle
    func viewDidLoad() {
        getGameDetails(by: id)
        getGameIsFavorite()
    }
    
    // Methods
    func favoriteButtonClicked() {
        
        if !gameIsFavorite {
            CoreDataFavoriGameClient.shared.saveFavoriteGame(id: id.toString()){ [weak self] result in
                switch result {
                case .success(let success):
                    self?.view?.showSuccessMessage(message: success.message)
                case .failure(let failure):
                    self?.view?.showErrorMessage(message: failure.message)
                    return
                }
            }
        } else {
            CoreDataFavoriGameClient.shared.deleteFavoriGame(id: id.toString()){ [weak self] result in
                switch result {
                case .success(let success):
                    self?.view?.showSuccessMessage(message: success.message)
                case .failure(let failure):
                    self?.view?.showErrorMessage(message: failure.message)
                    return
                }
            }
        }
        gameIsFavorite.toggle()
        view?.changeButtonColor(gameIsFavorite)
    }
    
    //MARK: - Private Methods
    private func getGameDetails(by id: Int){
        NetworkManager.shared.getGameDetails(by: id) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let game):
                self?.view?.prepareInterfaceComponent(game: game)
            }
        }
    }
    
    private func getGameIsFavorite(){
        guard let _ = CoreDataFavoriGameClient.shared.getFavoriteGame(by: id.toString()) else {
            self.gameIsFavorite = false
            view?.changeButtonColor(false)
            return
        }
        gameIsFavorite = true
        view?.changeButtonColor(true)
    }
}
