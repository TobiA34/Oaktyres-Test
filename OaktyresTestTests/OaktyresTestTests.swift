//
//  OaktyresTestTests.swift
//  OaktyresTestTests
//
//  Created by Tobi Adegoroye on 06/08/2023.
//

import XCTest
@testable import OaktyresTest

final class OaktyresTestTests: XCTestCase {
    let decoder = JSONDecoder()
    
    func testCanParseBeer() throws {
        
        let json = """
        [
            {
               "id":1,
               "name":"Buzz",
               "tagline":"A Real Bitter Experience.",
               "first_brewed":"09/2007",
               "description":"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
               "image_url":"https://images.punkapi.com/v2/keg.png",
               "abv":4.5,
               "ibu":60,
               "target_fg":1010,
               "target_og":1044,
               "ebc":20,
               "srm":10,
               "ph":4.4,
               "attenuation_level":75,
            },
        ]
     """
        guard let jsonData = json.data(using: .utf8) else {return}
        if let beer = try? decoder.decode([Beer].self, from: jsonData) {
            XCTAssertEqual("Buzz", beer[0].name)
            XCTAssertEqual("tagline", beer[0].tagline)
        }
    }
    
    func testCanParseEmptyBeerIbu() throws {
        
        
        let json = """
        [
            {
               "id":1,
               "name":"",
               "tagline":"A Real Bitter Experience.",
               "first_brewed":"09/2007",
               "description":"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
               "image_url":"https://images.punkapi.com/v2/keg.png",
               "abv":4.5,
               "ibu":,
               "target_fg":1010,
               "target_og":1044,
               "ebc":20,
               "srm":10,
               "ph":4.4,
               "attenuation_level":75,
            },
        ]
     """
        guard let jsonData = json.data(using: .utf8) else {return}
        if let beer = try? decoder.decode([Beer].self, from: jsonData) {
            XCTAssertEqual("", beer[0].name)
        }
    }
    
    func testCanParseFromJsonFile() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "beer", ofType: "json") else {
            return print("json not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            return print("json cannot be converted")
        }
        
        guard let jsonData = json.data(using: .utf8) else {return}
        if let beer = try? decoder.decode([Beer].self, from: jsonData) {
            XCTAssertEqual("Buzz", beer[0].name)
        }
    }
}
