//
//  MainView.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.10.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var tabViewModel = TabViewModel()

    var body: some View {
        TabView(selection: $tabViewModel.selectedTab) {
            CalendarView(tabViewModel: tabViewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Program")
                }
                .tag(0)

            ShowsList()
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Channel")
                }
                .tag(1)

            HelpView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
    }
}


#Preview {
    MainView()
}
