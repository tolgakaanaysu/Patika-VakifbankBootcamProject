//
//  CommunicationBetweenModules.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import UIKit

final class CommunicationBetweenModules {
    static let shared = CommunicationBetweenModules()
    
    private init() {}
    
    func post(name: String){
        NotificationCenter.default.post(name: NSNotification.Name(name), object: nil)
    }
    
    func observe(observer: Any, name: String, selector: Selector){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(name), object: nil)
    }
}

enum CommunicationMessage:String {
    case changedFavoriteStatus = "changedFavoriteStatus"
    case gameDetailDataNotFound = "gameDetailDataNotFound"
    case favoriteGameDetailDataNotFound = "favoriteGameDetailDataNotFound"
    case noteListChanged = "noteListChanged"
}

