//
//  CoreDataError.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 8.01.2023.
//

import Foundation

//MARK: - Enums
enum CoreDataCustomError {
    case saveError
    case loadError
    case updateError
    case deleteError
}

extension CoreDataCustomError: Error {
    var message: String {
        switch self {
        case .loadError:
            return "Failed to load"
        case .saveError:
            return "Failed to save"
        case .updateError:
            return "Failed to update"
        case .deleteError:
            return "Failed to delete"
        }
    }
}
