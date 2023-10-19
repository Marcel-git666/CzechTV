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
        formatter.timeStyle = .none
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}
