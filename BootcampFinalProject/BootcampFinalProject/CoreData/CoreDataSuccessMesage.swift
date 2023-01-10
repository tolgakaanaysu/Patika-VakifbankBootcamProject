//
//  CoreDataSuccessMesage.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 8.01.2023.
//

import Foundation

enum CoreDataCustomSuccesMessage {
    case saveSuccess
    case updateSucces
    case deleteSucces
}

extension CoreDataCustomSuccesMessage {
    var message: String {
        switch self {
        case .saveSuccess:
            return "Successfully saved"
        case .updateSucces:
            return "Successfully edited"
        case .deleteSucces:
            return "Successfully deleted"
        }
    }
}

