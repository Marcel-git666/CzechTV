//
//  Extensions.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.10.2023.
//

import Foundation

extension Date {
    var onlyDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
