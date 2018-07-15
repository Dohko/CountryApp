//
//  CountryCellViewModel.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

struct CountryCellViewModel {
    var nativeNameText: String { return country.nativeName }
    var englishNameText: String { return country.name }

    let country: Country
}
