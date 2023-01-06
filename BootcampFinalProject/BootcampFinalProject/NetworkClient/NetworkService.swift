//
//  NetworkService.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 6.01.2023.
//

import Foundation

protocol NetworkService {
    func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (Result<ResponseType, NetworkServiceError>) -> Void)
}

final class URLSessionNetworkService: NetworkService {
    //MARK: - Generic GET Request Method
    func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (Result<ResponseType, NetworkServiceError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkServiceError.noData))
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(NetworkServiceError.dataParseError))
            }
        }
        task.resume()
    }
}
