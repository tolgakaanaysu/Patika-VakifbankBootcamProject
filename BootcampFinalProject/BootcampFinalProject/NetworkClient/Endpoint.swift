//
//  Endpoint.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import Foundation

struct Endpoint {
    //FIXME: Apikey could not hard coded
    private let apiKeyItem = URLQueryItem(name: "key", value: "a670dcc50a3f4dc28ce54a651b5a8ab6" /*API KEY*/)
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
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    init(path: String,queryItem: [QueryItem]) {
        self.queryItems = queryItem.map({$0.urlQueryItem})
        self.queryItems.append(apiKeyItem)
        self.path = path
    }
}

extension Endpoint {
    static func getAllGames(queryItems: [QueryItem]) -> Endpoint {
        return Endpoint(path: EndpointPath.allGames.path, queryItem: queryItems)
    }
   
    static func getGameDetails(withID id: String) -> Endpoint {
        return Endpoint(path: EndpointPath.gameDetails(id).path, queryItem: [])
    }
}

enum EndpointPath {
    case allGames
    case gameDetails(String)
    
    var path: String {
        switch self {
        case .allGames:
            return "games"
        case .gameDetails(let id):
            return "games/\(id)"
        }
    }
}
