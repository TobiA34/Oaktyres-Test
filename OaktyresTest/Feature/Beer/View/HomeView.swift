//
//  ContentView.swift
//  OaktyresTest
//
//  Created by Tobi Adegoroye on 03/08/2023.
//

import SwiftUI


extension TextField {
    func styleTextField() -> some View {
        return self
        
    }
}

struct HomeView: View {
    
    @StateObject private var vm = BeerViewModel()
    @State private var searchTerm = ""
    @Environment(\.colorScheme) private var colorScheme
    
    private var listData: [Beer] {
        if searchTerm.isEmpty {
            return vm.beers
        } else {
            return vm.searchResult
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                background
                
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    List {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .padding(.leading, 8)
                            TextField("Find A beer", text: $searchTerm)
                                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                .onChange(of: searchTerm) { searchTerm in
                                    vm.search(term: searchTerm)
                                }
                        }
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        
                        ForEach(listData, id: \.id) { beer in
                            BeerView(beer: beer)
                                .listRowSeparator(.hidden)
                        }
                        .navigationTitle("Oaktyres Test")
                        .animation(.default, value: searchTerm)
                    }
                    .listStyle(.plain)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack{
                                Text("Oaktyres test")
                                    .font(Font.largeTitle.bold())
                                    .foregroundColor(colorScheme == .light ? .white: .black)
                            }
                        }
                    }
                    .background(.blue)
                }
            }
        }
        .onAppear(perform: vm.getBeers)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button(action:vm.getBeers) {
                Text("Retry")
            }
        }
    }
}

private extension HomeView {
    var background: some View {
        Theme.primary.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
