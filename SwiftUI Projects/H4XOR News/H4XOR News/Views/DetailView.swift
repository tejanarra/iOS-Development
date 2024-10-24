//
//  DetailView.swift
//  H4XOR News
//
//  Created by Teja Narra on 10/23/24.
//

import SwiftUI
import WebKit

struct DetailView: View {
    
    var url: String?
    
    
    
    var body: some View {
        WebView(urlString: url)
    }
}

#Preview {
    DetailView(url:"https://google.com")
}

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let urlString: String?
    
    func makeUIView(context: Context) ->  WebView.UIViewType {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let safeUrl = urlString {
            uiView.load(URLRequest(url: URL(string: safeUrl)!))
        }
    }
    
    
}
