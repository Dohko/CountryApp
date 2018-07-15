//
//  CountriesViewModel.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import Foundation

class CountriesViewModel {
    
    let cellIdentifier = "CountryCellIdentifier"
    let segueIdentifier = "CountryViewControllerSegue"

    var requestFailed: ((Error?)->())?
    var reloadTable: (()->())?
    var loadingStatus: (()->())?

    var isLoading: Bool = false {
        didSet {
            self.loadingStatus?()
        }
    }
    
    private var countries: Countries?
    
    var numberOfCells: Int { return countryCellsViewModel.count }
    
    private var countryCellsViewModel: [CountryCellViewModel] = [CountryCellViewModel]() {
        didSet {
            reloadTable?()
        }
    }

    func request() {
        isLoading = true
        CountriesRequest().request { (countries, error) in
            self.isLoading = false
            if let error = error {
                self.requestFailed?(error)
            }
            else if let countries = countries {
                self.countriesReceived(countries)
            }
        }
    }
    
    func countriesReceived(_ countries: Countries) {
        self.countries = countries
        self.requestSuccess(countries)
    }
    
    private func requestSuccess(_ countries: Countries) {
        var countryCellsViewModel = [CountryCellViewModel]()
        countries.countries.forEach { country in
            countryCellsViewModel.append(CountryCellViewModel(country: country))
        }
        self.countryCellsViewModel = countryCellsViewModel
    }
    
    func countryCellViewModel(at indexPath: IndexPath) -> CountryCellViewModel {
        return countryCellsViewModel[indexPath.row]
    }

    func border(for country: Country) -> [Country] {
        return countries?.border(for:country) ?? []
    }

}
