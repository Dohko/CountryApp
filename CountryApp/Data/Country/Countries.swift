//
//  Countries.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

struct Countries: Codable {
    
    let countries: [Country]
    
    func border(for country: Country) -> [Country] {
        return countries.filter { country.borders.contains($0.alpha3Code) }
    }
    
}
