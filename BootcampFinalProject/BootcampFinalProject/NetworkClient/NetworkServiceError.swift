//
//  URLSessionError.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 6.01.2023.
//

import Foundation

//MARK: - URLSessionDataTaskError
enum NetworkServiceError: Error {
    case noData
    case dataParseError
}

extension NetworkServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataParseError:
            return LocalizableConstant.dataParseError
        case .noData:
            return LocalizableConstant.noDataError
        }
    }
}
