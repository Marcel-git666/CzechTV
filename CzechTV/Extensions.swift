//
//  Extensions.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.10.2023.
//

import Foundation

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: self)
    }
}
