//
//  GameModel.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import Foundation

struct Game: Decodable {
    let id: Int
    let name: String
    let rating: Double
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case imageUrl = "background_image"
    }
}

