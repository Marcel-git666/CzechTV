//
//  ShowsList.swift
//  CzechTV
//
//  Created by Marcel Mravec on 25.02.2023.
//

import SwiftUI

struct ShowsList: View {
    @ObservedObject var networkManager = NetworkManager()
    let date: Date
    let channel: Channels
    
    init(date: Date = Date.now, channel: Channels = .ct1) {
        self.date = date
        self.channel = channel
    }
    
    var body: some View {
        List {
            Text("Program \(channel.rawValue)")
                .fontWeight(.bold)
            ForEach(networkManager.program.porad, id: \.self) { show in
                NavigationLink(destination: ShowDetailView(show: show)) {
                    HStack {
                        AsyncImage(url: URL(string: show.obrazky.tv_program))
                            .frame(width: 80, height: 50)
                        Text(show.cas)
                        Text(show.nazvy.nazev)
                    }
                }
            }
            
            
        }
        .onAppear {
            networkManager.fetchData(date: date, channel: channel)
        }
    }
}

struct ShowsList_Previews: PreviewProvider {
    static var previews: some View {
        ShowsList(date: Date.now, channel: .ct4)
    }
}

