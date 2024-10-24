//
//  ContentView.swift
//  H4XOR News
//
//  Created by Teja Narra on 10/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager:NetwrokManager=NetwrokManager()
    
    var body: some View {
        NavigationView{
            List(networkManager.posts){(post) in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
                
            }
            .navigationTitle("H4XOR News")
        }.onAppear {
            self.networkManager.fetchData()
        }
    }
}

#Preview {
    ContentView()
}
