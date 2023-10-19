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
        formatter.dateStyle = .medium  
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
