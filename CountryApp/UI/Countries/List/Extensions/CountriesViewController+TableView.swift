//
//  CountriesViewController+TableView.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import UIKit

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getRowFor(indexPath: indexPath, dequeueForHeight: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = getRowFor(indexPath: indexPath, dequeueForHeight: true)
        return cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryViewModel = viewModel.countryCellViewModel(at: indexPath)
        performSegue(withIdentifier: viewModel.segueIdentifier, sender: countryViewModel.country)
    }
    
    private func getRowFor(indexPath:IndexPath, dequeueForHeight: Bool = false) -> UITableViewCell {
        guard let tableView = tableView,
                let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier) as? CountryCell else { return UITableViewCell() }
        let countryViewModel = viewModel.countryCellViewModel(at: indexPath)
        cell.nativeNameLabel?.text = countryViewModel.nativeNameText
        cell.englishNameLabel?.text = countryViewModel.englishNameText
        
        return cell
    }
    
}
