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
    private lazy var networkManager: NetworkManagerProtocol = NetworkManager()
    var view: DetailsViewControllerDelegate?
    var id: Int!
     var game: GameDetail?
     var gameIsFavorite: Bool = false
    
    
    //MARK: - Lifecycle
    func viewDidLoad() {
        getGameDetails(by: id)
        getGameIsFavorite()
    }
    
    // Methods
    func favoriteButtonClicked() {
        guard let game else { return }
        if !gameIsFavorite {
            CoreDataFavoriGameClient.shared.saveFavoriteGame(id: id.toString(), name: game.name){ [weak self] result in
                switch result {
                case .success(let success):
                    self?.view?.showSuccessAlert(message: success.message)
                case .failure(let error):
                    self?.view?.showErrorAlert(message: error.message)
                    return
                }
            }
        } else {
            CoreDataFavoriGameClient.shared.deleteFavoriGame(id: id.toString()){ [weak self] result in
                switch result {
                case .success(let success):
                    self?.view?.showSuccessAlert(message: success.message)
                case .failure(let error):
                    self?.view?.showErrorAlert(message: error.message)
                    return
                }
            }
        }
        gameIsFavorite.toggle()
        view?.changeButtonColor(gameIsFavorite)
        favoriteStatusDidChanged()
    }
    
    //MARK: - Private Methods
    func getGameDetails(by id: Int){
        view?.startProgressAnimating()
        networkManager.getGameDetails(by: id) { [weak self] result in
            self?.view?.stopAnimating()
            switch result {
            case .failure(_):
                self?.sendNotificationForDataNotFound()
                self?.view?.popViewController()
                
            case .success(let game):
                self?.view?.prepareInterfaceComponent(game: game)
                self?.game = game
            }
        }
    }
    
    func getGameIsFavorite(){
        guard let _ = CoreDataFavoriGameClient.shared.getFavoriteGame(by: id.toString()) else {
            self.gameIsFavorite = false
            view?.changeButtonColor(false)
            return
        }
        gameIsFavorite = true
        view?.changeButtonColor(true)
    }
    
    private func favoriteStatusDidChanged(){
        CommunicationBetweenModules.shared.post(name: CommunicationMessage.changedFavoriteStatus.rawValue)
    }
    
    private func sendNotificationForDataNotFound(){
        CommunicationBetweenModules.shared.post(name: CommunicationMessage.favoriteGameDetailDataNotFound.rawValue)
    }
}
