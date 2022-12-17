//
//  Endpoint.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import Foundation


struct Endpoint {
    private static let apiKeyItem = URLQueryItem(name: "key", value: "a670dcc50a3f4dc28ce54a651b5a8ab6" /*API KEY*/)
    private let schema = "https"
    private let host = "api.rawg.io"
    private let prePath = "/api/"
    
    var path: String
    var queryItems: [URLQueryItem] = []
    var url: URL {
        var components = URLComponents()
        components.scheme = schema
        components.host = host
        components.path = prePath + path
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
        var items = queryItems
        items.append(Endpoint.apiKeyItem)
        return Endpoint(path: "games",queryItems: items )
    }
    
    static func getGameDetails(withID id: String) -> Endpoint {
        return Endpoint(path: "games/\(id)")
    }
}
