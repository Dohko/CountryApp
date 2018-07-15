//
//  Country.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

struct Country: Codable {
    
    let name: String
    let topLevelDomain: [String]
    let alpha2Code: String
    let alpha3Code: String
    let callingCodes: [String]
    let capital: String
    let altSpellings: [String]
    let region: String
    let subregion: String
    let population: Int
    let latlng: [Double]
    let demonym: String
    let area: Decimal?
    let gini: Decimal?
    let timezones: [String]
    let borders: [String]
    let nativeName: String
    let numericCode: String?
    let flag: String

}
