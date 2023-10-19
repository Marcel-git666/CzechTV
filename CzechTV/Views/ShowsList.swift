//
//  ShowsList.swift
//  CzechTV
//
//  Created by Marcel Mravec on 25.02.2023.
//

import SwiftUI

struct ShowsList: View {
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var tabViewModel: TabViewModel
    
    
    var body: some View {
        NavigationStack {
            List {
                Text("Program \(tabViewModel.selectedChannel.rawValue) \(tabViewModel.selectedDate.onlyDate)")
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
                networkManager.fetchData(date: tabViewModel.selectedDate, channel: tabViewModel.selectedChannel)
        }
        }
    }
}

struct ShowsList_Previews: PreviewProvider {
    static let tabViewModel = TabViewModel()
    static var previews: some View {
        ShowsList(tabViewModel: tabViewModel)
    }
}

