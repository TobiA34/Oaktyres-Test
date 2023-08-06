//
//  BeerInfoView.swift
//  OaktyresTest
//
//  Created by Tobi Adegoroye on 04/08/2023.
//

import SwiftUI

struct BeerInfoView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let beer: Beer
    
    var body: some View {
        
        List {
            
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: beer.imageUrl)){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 380,height: 350)
                
            }
            
            Section(header: Text("Tagline").padding(.trailing, 140)) {
                VStack {
                    Text(beer.tagline)
                }
                
            }
            
            Section(header: Text("Details")) {
                Text("Name: \(beer.name)")
                Text("First brewed: \(beer.firstBrewed)")
                Text("abv: \(beer.abv ?? 0)")
                Text("ibu: \(beer.ibu ?? 0)")
            }
        }
        .scrollContentBackground(.hidden)
        .cornerRadius(16)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .listStyle(.insetGrouped)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(beer.name)
                    .font(.largeTitle.bold())
                    .accessibilityAddTraits(.isHeader)
            }
        }
    }
}
