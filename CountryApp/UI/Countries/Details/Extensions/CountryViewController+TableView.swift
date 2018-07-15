//
//  CountryViewController+TableView.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import UIKit

import UIKit

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
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
    
    private func getRowFor(indexPath:IndexPath, dequeueForHeight: Bool = false) -> UITableViewCell {
        guard let tableView = tableView,
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CountryCell else { return UITableViewCell() }

        let country = countries?[indexPath.row]
        cell.nativeNameLabel?.text = country?.nativeName
        cell.englishNameLabel?.text = country?.name
        
        return cell
    }
    
}
