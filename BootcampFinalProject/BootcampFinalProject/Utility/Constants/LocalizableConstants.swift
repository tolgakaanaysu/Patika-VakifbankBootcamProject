//
//  Constants.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 16.12.2022.
//

import Foundation

struct LocalizableConstant {
    //MARK: -  Homepage action sheet
    static let menuActionSheetMessage = NSLocalizedString("menuActionSheetMessage", comment: "Please choise one item")
    static let menuActionSheetTitle = NSLocalizedString("menuActionSheetTitle", comment: "Filter")
    static let menuButtonNameItem = "Name"
    static let menuButtonRatingItem = "Rating"
    static let menuButtonFavoriteItem = "Favorite"
    
    //MARK: -  Searchbar
    static let searchBarPlaceholder = NSLocalizedString("searchBarPlaceholder", comment: "Type something to search")
    
    //MARK: -  View Controllers Title
    static let favoriteListTitle = NSLocalizedString("favoriteListTitle", comment: "My Favorite Games")
    static let noteListTitle = NSLocalizedString("noteListTitle", comment: "My Notes")
    
    //MARK: - Core Data errors
    static let noDataError = NSLocalizedString("noDataError", comment: "Data not found. Plase check network connection")
    static let dataParseError = NSLocalizedString("dataParseError", comment: "Data not found")
    
    
  
}



