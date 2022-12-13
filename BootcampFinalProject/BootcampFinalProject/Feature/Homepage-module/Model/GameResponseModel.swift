//
//  GameResponseModel.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import Foundation

struct GameResponseModel: Codable {
    let count: Int
    let next: String
    let results: [Game]
}
