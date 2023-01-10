//
//  QueryItem.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 8.01.2023.
//

import Foundation

enum QueryItem {
   case ordering(String)
}

extension QueryItem {
    var urlQueryItem: URLQueryItem {
        switch self {
        case .ordering(let value):
            return URLQueryItem(name: "ordering", value: value)
        }
    }
}
