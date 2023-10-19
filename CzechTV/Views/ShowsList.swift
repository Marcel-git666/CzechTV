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
            ZStack {
                Color.green.opacity(0.2).edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("\(tabViewModel.selectedChannel.rawValue) \(tabViewModel.selectedDate.onlyDate)")
                        .fontWeight(.bold)
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(networkManager.program.porad, id: \.self) { show in
                                NavigationLink(destination: ShowDetailView(show: show)) {
                                    HStack {
                                        AsyncImage(url: URL(string: show.obrazky.tv_program))
                                            .frame(width: 50, height: 50)
                                        VStack(alignment: .leading) {
                                            Text(show.cas)
                                            Text(show.nazvy.nazev)
                                        }
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
                .onAppear {
                    networkManager.fetchData(date: tabViewModel.selectedDate, channel: tabViewModel.selectedChannel)
                }
                .navigationTitle("Program List")
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

