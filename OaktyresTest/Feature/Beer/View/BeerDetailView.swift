//
//  DetailView.swift
//  OaktyresTest
//
//  Created by Tobi Adegoroye on 04/08/2023.
//

import SwiftUI

struct BeerDetailView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let beer: Beer
    
    var body: some View {
        
        BeerInfoView(beer: beer)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(beer.name)
                            .lineLimit(0)
                            .font(.title2.bold())
                    }
                }
            }
    }
}
