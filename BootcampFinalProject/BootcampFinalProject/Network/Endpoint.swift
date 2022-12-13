//
//  Endpoint.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import Foundation

struct Endpoint {
    private static let apiKeyItem = URLQueryItem(name: "key", value: "" /*API KEY*/)
    var path: String
    var queryItems: [URLQueryItem] = []
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.rawg.io"
        components.path = "/api/" + path
        components.queryItems = queryItems
        components.queryItems?.append(Endpoint.apiKeyItem)
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

extension Endpoint {
    static func getAllGames(queryItems: [URLQueryItem]) -> Endpoint {
        return Endpoint(path: "games",queryItems: queryItems )
    }
    
    static func getGameDetails(withID id: String) -> Endpoint {
        return Endpoint(path: "games/\(id)")
    }
}
