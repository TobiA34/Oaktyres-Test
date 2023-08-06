//
//  Beer.swift
//  OaktyresTest
//
//  Created by Tobi Adegoroye on 03/08/2023.
//

import Foundation

struct Beer: Codable {
    let id: Int
    let name,tagline: String
    let imageUrl: String
    let firstBrewed: String
    let abv: Double?
    let ibu: Double?
    
    static let data = Beer(id: 1,
                           name: "Peach Beer",
                           tagline: "Amazing",
                           imageUrl: "www.peach-g-png.com",
                           firstBrewed: "07/2000",
                           abv: 2.2,
                           ibu: 60.0)
}



