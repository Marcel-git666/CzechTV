//
//  TabViewModel.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.10.2023.
//

import Foundation

class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var selectedDate: Date = Date.now
    @Published var selectedChannel: Channels = .ct1
}
