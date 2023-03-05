//
//  WebView.swift
//  CzechTV
//
//  Created by Marcel Mravec on 01.03.2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var urlString: String?
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
        
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://google.com")
    }
}
