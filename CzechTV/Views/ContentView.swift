//
//  ContentView.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.02.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var channel: Channels = .ct1
    @State private var date = Date.now
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack {
                    Text("Choose channel")
                        .font(.title)
                    Picker("Channel?", selection: $channel ) {
                        
                        ForEach(Channels.allCases) { ch in
                            Text(ch.rawValue)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Text("Enter a day for TV program:")
                    .font(.title)
                DatePicker("Choose a date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .accentColor(.green)            .padding()                .background(RoundedRectangle(cornerRadius: 20)                                .fill(Color.green) .opacity(0.1)   .shadow(radius: 1, x: 4, y: 4))        .padding(.horizontal)

                NavigationLink("Show channel: \(channel.rawValue) on \(date, formatter: dateFormatter)", destination: ShowsList(date: date, channel: channel))
            
            }
            .navigationTitle("Program ČT")
        }
        .onAppear {
            networkManager.fetchData(date: date, channel: channel)
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

