//
//  ContentView.swift
//  CzechTV
//
//  Created by Marcel Mravec on 19.02.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List {
                Text("Program CT4")
                
            }
        }
        .onAppear {
            networkManager.fetchData()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
