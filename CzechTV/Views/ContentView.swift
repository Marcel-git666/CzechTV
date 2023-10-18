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
    @State private var showingAboutAlert = false
    @State private var showToday = false
    @State private var showHelp = false
    
    var body: some View {
        NavigationView {
            VStack {
                ChannelPickerView(channel: $channel)
                DatePickerView(date: $date)
                Button("Fetch Program") {
                    fetchData()
                }
                .buttonStyle(CustomButtonStyle())
                
                if networkManager.program.porad.isEmpty {
                    Text("No program data available.")
                } else {
                    NavigationLinkView(date: $date, channel: $channel)
                }
                
            }
            .navigationTitle("Program ČT")
            .toolbar {
                Button("About") {
                    showingAboutAlert = true
                }
                .alert("Program ČT is made by Marcel", isPresented: $showingAboutAlert) {
                    Button("OK", role: .cancel) { }
                }
                .buttonStyle(CustomButtonStyle()) // Apply the custom button style
                
                Button("Today") {
                    showToday = true
                }
                .navigationDestination(isPresented: $showToday) {
                    ShowsList(date: Date.now, channel: channel)
                }
                .buttonStyle(CustomButtonStyle()) // Apply the custom button style
                
                Button("Help") {
                    showHelp = true
                }
                .navigationDestination(isPresented: $showHelp) {
                    HelpView()
                }
                .buttonStyle(CustomButtonStyle()) // Apply the custom button style
            }
        }
    }
    
    private func fetchData() {
        networkManager.fetchData(date: date, channel: channel) { result in
            switch result {
            case .success:
                // Handle success, no need for specific action here.
                break
            case .failure(let error):
                switch error {
                case .invalidData:
                    // Handle invalid data error
                    print("Invalid data error")
                case .decodingError(let decodingError):
                    // Handle decoding error
                    print("Decoding error: \(decodingError.localizedDescription)")
                case .networkError(let networkError):
                    // Handle network error
                    print("Network error: \(networkError.localizedDescription)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ChannelPickerView: View {
    @Binding var channel: Channels
    var body: some View {
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
    }
}

struct DatePickerView: View {
    @Binding var date: Date
    var body: some View {
        DatePicker("Choose a date", selection: $date, displayedComponents: .date)
            .datePickerStyle(.graphical)
            .accentColor(.green)            .padding()                .background(RoundedRectangle(cornerRadius: 20)                                .fill(Color.green) .opacity(0.2)   .shadow(radius: 1, x: 4, y: 4))        .padding(.horizontal)
    }
}

struct NavigationLinkView: View {
    @Binding var date: Date
    @Binding var channel: Channels
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        NavigationLink("Show channel: \(channel.rawValue) on \(date, formatter: dateFormatter)", destination: ShowsList(date: date, channel: channel))
    }
}


struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.green.opacity(0.5) : Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
