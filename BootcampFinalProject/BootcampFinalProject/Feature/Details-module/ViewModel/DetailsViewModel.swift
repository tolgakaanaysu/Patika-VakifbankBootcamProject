//
//  DetailsViewModel.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 14.12.2022.
//

import Foundation

protocol DetailsViewModelDelegate {
    var view: DetailsViewControllerDelegate? { get set }
    
    func viewDidLoad(id: Int)
}

final class DetailsViewModel: DetailsViewModelDelegate {
    //MARK: - Property
    var view: DetailsViewControllerDelegate?
    
    //MARK: - Lifecycle
    func viewDidLoad(id: Int) {
        getGameDetails(by: id)
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
}
