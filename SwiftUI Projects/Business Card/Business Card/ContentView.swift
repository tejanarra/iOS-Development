//
//  ContentView.swift
//  Business Card
//
//  Created by Teja Narra on 10/22/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.09, green: 0.63, blue: 0.52, opacity: 1.00).ignoresSafeArea(.all)
            VStack {
                Image("Profile-Image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle()).overlay(Circle().stroke(Color.white, lineWidth: 5))

                Text("Teja Narra")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundColor(.white)
                
                Text("IOS Developer")
                    .font(Font.custom("Poppins-Regular", size: 20))
                    .foregroundColor(.white)
                
                Divider()
                
                    
                
                InfoView(text: "+1 (312)-593-7394", image: "phone.fill")
                InfoView(text: "narrateja9699@gmail.com", image: "envelope.fill")

            }
        }
    }
}

#Preview {
    ContentView()
}


