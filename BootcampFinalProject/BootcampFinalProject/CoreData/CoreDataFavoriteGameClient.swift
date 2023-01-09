//
//  CoreDataFavoriteGameClient.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 14.12.2022.
//

import Foundation

final class CoreDataFavoriGameClient {
    //MARK: - Property
    static let shared: CoreDataFavoriGameClient = CoreDataFavoriGameClient()
    private let coredata: CoreDataManager
    
    //MARK: - init
    private init(){
        self.coredata = CoreDataManager(entityName: "FavoriteGame")
    }
    
    //MARK: - Methods
    func saveFavoriteGame(id: String, name: String, completion: @escaping(Result<CoreDataCustomSuccesMessage,CoreDataCustomError>) -> Void){
        coredata.saveObject() { object in
            object.setValue(id, forKey: "id")
            object.setValue(true, forKey: "isFavorite")
            object.setValue(name, forKey: "name")
        } completion: { result in
            completion(result)
        }
    }
    
    func deleteFavoriGame(id: String, completion: @escaping(Result<CoreDataCustomSuccesMessage,CoreDataCustomError>) -> Void) {
        guard let willDeleteGame = coredata.getObject(by: id) as? FavoriteGame else { return }
        coredata.deleteObject(model: willDeleteGame) { result in
           completion(result)
        }
    }
    
    func getFavoriteGame(by id: String) -> FavoriteGame? {
        coredata.getObject(by: id)
    }
    
    func getAllFavoriteGame(comletion: @escaping(Result<[FavoriteGame],CoreDataCustomError>) -> Void){
        coredata.getAllObjects(responseType: FavoriteGame.self) { result in
            comletion(result)
        }
    }
}
