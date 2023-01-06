//
//  NetworkManager.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import Foundation

//MARK: - NetworkManagerProtocol
protocol NetworkManagerProtocol {
    func getAllGames(queryItems: [URLQueryItem], completion: @escaping(Result<[Game],Error>) -> Void)
    func getGameDetails(by id: Int, completion: @escaping(Result<GameDetail,Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    //MARK: - Property
    private var networkService: NetworkService = URLSessionNetworkService()
    
    //MARK: - Methods
    func getAllGames(queryItems: [URLQueryItem], completion: @escaping(Result<[Game],Error>) -> Void){
        let url = Endpoint.getAllGames(queryItems: queryItems).url
        networkService.taskForGETRequest(url: url, responseType: GameResponseModel.self) { result in
            switch result {
            case .success(let games):
                completion(.success(games.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getGameDetails(by id: Int, completion: @escaping(Result<GameDetail,Error>) -> Void){
        let url = Endpoint.getGameDetails(withID: id.toString()).url
        networkService.taskForGETRequest(url: url, responseType: GameDetail.self) { result in
            switch result {
            case .success(let game):
                completion(.success(game))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
