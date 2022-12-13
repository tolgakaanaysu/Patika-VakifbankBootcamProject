//
//  Extension.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import Foundation

extension Int {
    func toString() -> String {
        String(describing: self)
    }
}

extension Double {
    func toString() -> String {
        String(describing: self)
    }
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self == nil || self == ""
    }
}
