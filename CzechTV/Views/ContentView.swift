//
//  ContentView.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.02.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var description = "First"
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
                
                Text("WHy?")
                Text(description.prefix(4))
            }
        }
        .onAppear {
            networkManager.fetchData()
            description = networkManager.xmlPage
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
