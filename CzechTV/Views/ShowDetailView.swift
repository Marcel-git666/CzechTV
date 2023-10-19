//
//  ShowDetailView.swift
//  CzechTV
//
//  Created by Marcel Mravec on 28.02.2023.
//

import SwiftUI

struct ShowDetailView: View {
    let show: Porad?
    var body: some View {
        
        ZStack {
            Color.green
                .opacity(0.2)
                .edgesIgnoringSafeArea(.all)
                
            VStack {
                AsyncImage(url: URL(string: show?.obrazky.nahled ?? "https://img.ceskatelevize.cz/program/porady/16111/foto/uni.jpg")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                } placeholder: {
                    Color.gray
                }
                .frame(width: 250, height: 250)

                HStack {
                    Text(show?.cas ?? "10:00")
                    Text(show?.nazvy.nazev ?? "Název pořadu")
                }
                HStack {
                    Text(show?.zanr ?? "Zábava")
                    Text(show?.noticka ?? "Témata ze školní biologie ve světle nejnovějších poznatků vědeckých pracovišť. Pořad pro žáky 2. stupně ZŠ")
                }
                NavigationLink(destination: WebView(urlString: show?.linky.ivysilani)) {
                    
                    
                    Text(show?.linky.ivysilani ?? "Žádný odkaz na ivysilani.cz")
                    
                }
                
                Spacer()
                
            }
            .navigationTitle(show?.nazvy.nazev ?? "Název pořadu")
        }
    }
}

struct ShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailView(show: Porad.example)
    }
}
