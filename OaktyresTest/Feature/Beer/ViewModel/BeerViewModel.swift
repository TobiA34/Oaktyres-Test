//
//  BeerViewModel.swift
//  OaktyresTest
//
//  Created by Tobi Adegoroye on 03/08/2023.
//

import Foundation


class BeerViewModel: ObservableObject {
    
    @Published var beers: [Beer] = []
    @Published var hasError = false
    @Published var error: BeerError?
    @Published private(set) var isRefreshing =  false
    @Published var searchResult: [Beer] = []
    
    
    func getBeers() {
        isRefreshing = true
        hasError = false
        
        let beerUrl = "https://api.punkapi.com/v2/beers"
        if let url = URL(string: beerUrl) {
            
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    DispatchQueue.main.async {
                        
                        if let error = error {
                            self?.hasError = true
                            self?.error = BeerError.custom(error: error)
                            print(error)
                        } else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            
                            if let data = data,
                               let beers = try? decoder.decode([Beer].self, from: data) {
                                self?.beers = beers
                            } else {
                                //TODO: Handle Error
                                self?.hasError = true
                                self?.error = BeerError.failedToDecode
                            }
                        }
                        self?.isRefreshing = false
                    }
                    
                }.resume()
        }
    }
    
    func search(term: String) {
        searchResult = beers.filter({ beer in
            beer.name.lowercased().contains(term.lowercased())
        })
    }
}

extension BeerViewModel {
    enum BeerError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
