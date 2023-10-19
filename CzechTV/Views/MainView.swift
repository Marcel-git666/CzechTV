//
//  MainView.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.10.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Program")
                }

            ShowsList()
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Channel")
                }

//            TodayShowsView()
//                .tabItem {
//                    Image(systemName: "sun.max")
//                    Text("Today")
//                }

            HelpView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    MainView()
}
