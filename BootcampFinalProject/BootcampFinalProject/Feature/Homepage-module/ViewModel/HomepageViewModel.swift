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
    var gameList = [Game]()
    
    //MARK: - Lifecycle
    func viewDidLoad() {
        view?.prepareCollectionView()
    }
    
    //MARK: - CollectionViewDataSourceMethods
    func numberOfItemsInSection() -> Int {
        gameList.count
    }
    
    func cellForItemAt(at indexPath: IndexPath) -> Game? {
        gameList[indexPath.row]
    }
}
