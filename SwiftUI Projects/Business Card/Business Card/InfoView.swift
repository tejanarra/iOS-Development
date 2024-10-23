//
//  InfoView.swift
//  Business Card
//
//  Created by Teja Narra on 10/22/24.
//

import SwiftUI

struct InfoView: View {
    var text: String
    var image: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25).foregroundColor(.white).frame(height: 50).padding(.all)
            HStack {
                Image(systemName: image)
                    .symbolEffect(.wiggle.wholeSymbol, options: .nonRepeating)
                    .foregroundColor(.green)
                Text(text).foregroundColor(Color("InfoView"))
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "+1 (312)-593-7394", image: "phone.fill").previewLayout(.sizeThatFits)
    }
}
