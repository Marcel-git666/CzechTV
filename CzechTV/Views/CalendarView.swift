//
//  ContentView.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.02.2023.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var channel: Channels = .ct1
    @State private var date = Date.now
    @State private var showingAboutAlert = false
    @State private var showHelp = false
    @State private var showToday = false
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20)  {
                ChannelPickerView(channel: $channel)
                DatePickerView(date: $date)
                NavigationLink("Show channel: \(channel.rawValue) on \(date, formatter: dateFormatter)", destination: ShowsList(date: date, channel: channel))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.green))
                    .shadow(radius: 2, x: 2, y: 2)
                    .foregroundColor(.white)
            
            }
            .navigationTitle("Program ČT")
            .toolbar {
                Button("About") {
                    showingAboutAlert = true
                }
                .alert("Program ČT is made by Marcel", isPresented: $showingAboutAlert) {
                    Button("OK", role: .cancel) { }
                }
                .foregroundColor(.green)
                .fontWeight(.bold)
                Button("Today") {
                    showToday = true
                }
                .navigationDestination(isPresented: $showToday, destination: {
                    ShowsList(date: Date.now, channel: channel)
                })
                .foregroundColor(.green)
                .fontWeight(.bold)
                Button("Help") {
                    showHelp = true
                }
                .navigationDestination(isPresented: $showHelp, destination: {
                    HelpView()
                })
                .foregroundColor(.green)
                .fontWeight(.bold)
            }
        }
//        .onAppear {
//            networkManager.fetchData(date: date, channel: channel)
//        
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}


struct ChannelPickerView: View {
    @Binding var channel: Channels
    
    var body: some View {
        VStack {
            Text("Choose channel")
                .font(.headline)
            Picker("Channel?", selection: $channel) {
                ForEach(Channels.allCases) { ch in
                    Text(ch.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.green.opacity(0.2))
                .shadow(radius: 1, x: 4, y: 4))
            .padding(.horizontal)
        }
    }
}


struct DatePickerView: View {
    @Binding var date: Date
    var body: some View {
        VStack {
            Text("Enter a day for TV program:")
                .font(.headline)
            DatePicker("Choose a date", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .accentColor(.green)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.green) .opacity(0.2)
                .shadow(radius: 1, x: 4, y: 4))
                .padding(.horizontal)
        }
    }
}
