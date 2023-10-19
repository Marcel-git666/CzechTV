//
//  HelpView.swift
//  CzechTV
//
//  Created by Marcel Mravec on 28.02.2023.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("This will be helpfull page how to use this app.")
            }
            .navigationTitle("Help")
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
