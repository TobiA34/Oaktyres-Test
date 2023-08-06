//
//  BeerView.swift
//  OaktyresTest
//
//  Created by Tobi Adegoroye on 03/08/2023.
//

import SwiftUI

struct BeerView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let beer: Beer
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text(beer.name)
                .font(Font.largeTitle.bold())
                .foregroundColor(colorScheme == .light ? .white: .black)
            Text(beer.tagline)
                .font(Font.subheadline.bold())
                .foregroundColor(colorScheme == .light ? .white: .black)
            AsyncImage(url: URL(string: beer.imageUrl)){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.frame(width: 380,height: 350)
            
            NavigationLink {
                BeerDetailView(beer: beer)
            } label: {
                Text("Show more")
                    .foregroundColor(colorScheme == .light ? .white: .black)
                    .font(Font.title)
                    .padding(.leading,120)
            }
        }.background(colorScheme == .light ? .gray: .white)
            .cornerRadius(16)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct BeerView_Previews: PreviewProvider {
    static var previews: some View {
        BeerView(beer: Beer.data)
    }
}
