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
    let nameOriginal:  String
    let gameDescription:  String
    let descriptionRaw:  String
    let rating : Int
    
    private enum CodingKeys: String, CodingKey {
        case id, name
        case nameOriginal = "name_original"
        case gameDescription = "description"
        case rating
        case descriptionRaw = "description_raw"
    }
}

