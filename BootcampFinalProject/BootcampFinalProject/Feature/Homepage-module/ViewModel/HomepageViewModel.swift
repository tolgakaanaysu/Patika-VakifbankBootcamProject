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
    func cellForItemAt(at index: Int) -> Game?
    func didSelectItemAt(at index: Int)
    func updateSearchResults(text: String?)
    func getGameID() -> Int?
    func getGameOrdering(with queryValue: String)
}

final class HomepageViewModel: HomepageViewModelDelegate {
    //MARK: - Property
    weak var view: HomepageViewControllerDelegate?
    private var id: Int?
    private lazy var networkMaganager: NetworkManagerProtocol = NetworkManager()
    private var mainGameList = [Game]() {
        didSet {
            filteredGameList = mainGameList
        }
    }
    private var filteredGameList = [Game]() {
        didSet {
            view?.collectionViewReloadData()
        }
    }
    
    //MARK: - Lifecycle
    func viewDidLoad() {
        view?.prepareComponents()
        getAllGames()
    }
    
    //MARK: - IBActionMethods
    func getGameOrdering(with queryValue: String) {
        let queryItem = URLQueryItem(name: "ordering", value: queryValue)
        getAllGames(queryItems: [queryItem])
    }
        
    //MARK: - CollectionViewDataSourceMethods
    func numberOfItemsInSection() -> Int {
        filteredGameList.count
    }
    
    func cellForItemAt(at index: Int) -> Game? {
        filteredGameList[index]
    }
    
    //MARK: - CollectionViewDelegateMethods
    func didSelectItemAt(at index: Int) {
        self.id = filteredGameList[index].id
        view?.performSegue(identifier: Identifiers.homepageVCToDetailsVC)
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
    func getAllGames(queryItems: [URLQueryItem] = []) {
        view?.startProgressAnimating()
        networkMaganager.getAllGames(queryItems: queryItems) {[weak self] result in
            guard let self else { return }
            self.view?.stopAnimating()
            switch result {
            case .success(let games):
                self.mainGameList = games
            case .failure(let error):
                self.view?.showErrorAlert(message: error.localizedDescription)
                print(error)
                return
            }
        }
    }
}
