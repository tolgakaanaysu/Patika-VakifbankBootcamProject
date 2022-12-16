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
    private var game: GameDetail?
    private var gameIsFavorite: Bool = false
    
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
    private func getGameDetails(by id: Int){
        view?.startProgressAnimating()
        NetworkManager.shared.getGameDetails(by: id) { [weak self] result in
            self?.view?.stopAnimating()
            switch result {
            case .failure(let error):
                self?.view?.showErrorAlert(message: error.localizedDescription)
            case .success(let game):
                self?.view?.prepareInterfaceComponent(game: game)
                self?.game = game
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
    
    private func favoriteStatusDidChanged(){
        //FIXME: Manage notify class
        NotificationCenter.default.post(name: NSNotification.Name(LocalMessage.favoriteStatusDidChanged), object: nil)
    }
}
