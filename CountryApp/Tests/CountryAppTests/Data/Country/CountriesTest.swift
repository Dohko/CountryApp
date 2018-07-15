//
//  CountriesTest.swift
//  CountryAppTests
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import XCTest
@testable import CountryApp

class CountriesTests: BaseTest {
    
    func testThatReturnBorderingCountries() {
        // Given
        expectation = XCTestExpectation(description: "should return the list of bordering countries")
        let data = contentFile(named: "countries")
        
        // When
        let decoded = try! JSONDecoder().decode([Country].self, from: data!)
        let countriesData = Countries(countries: decoded)

        // Then
        XCTAssertNotNil(countriesData)
        XCTAssertTrue(countriesData.countries.count > 0)
        XCTAssertTrue(countriesData.countries[0].borders.count == countriesData.border(for: countriesData.countries[0]).count)
    }

    func testThatDoesntReturnBorderingForInexistingCountry() {
        // Given
        expectation = XCTestExpectation(description: "should not return the list of bordering countries for inexisting country")
        let data = contentFile(named: "countries")
        
        // When
        let decoded = try! JSONDecoder().decode([Country].self, from: data!)
        let countriesData = Countries(countries: decoded)
        let fakeCountry = Country(name: "", topLevelDomain: [], alpha2Code: "", alpha3Code: "foobar", callingCodes: [], capital: "", altSpellings: [], region: "", subregion: "", population: 0, latlng: [], demonym: "", area: nil, gini: nil, timezones: [], borders: [], nativeName: "", numericCode: nil, flag: "")

        // Then
        XCTAssertNotNil(countriesData)
        XCTAssertTrue(countriesData.countries.count > 0)
        XCTAssertTrue(countriesData.border(for: fakeCountry).isEmpty)
    }

}
