//
//  CountriesRequest.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

class CountriesRequest: TinyNetwork<Countries> {
    
    override var urlString: String? { get { return "https://restcountries.eu/rest/v2/all" } }
    
    // There are no new countries being created every day...
    override var cachePolicy: NSURLRequest.CachePolicy { return .useProtocolCachePolicy }
    
    override func decode(_ data: Data) -> Countries? {
        guard let decoded = try? JSONDecoder().decode([Country].self, from: data) else { return nil}
        return Countries(countries: decoded)
    }
    
}
