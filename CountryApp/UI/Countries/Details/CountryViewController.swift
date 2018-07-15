//
//  CountryViewController.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    var from: Country?
    var countries: [Country]?
    
    let cellIdentifier = "CountryCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = from?.name
        tableView?.register(UINib(nibName: "CountryCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        tableView?.reloadData()
    }
    
}

