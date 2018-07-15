//
//  CountriesViewController.swift
//  CountryApp
//
//  Created by Morgan Fitussi on 15/07/2018.
//  Copyright © 2018 Maccabi. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var errorLabel: UILabel?

    lazy var viewModel: CountriesViewModel = { return CountriesViewModel() }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? CountryViewController,
            let country = sender as? Country else { return }
        controller.from = country
        controller.countries = viewModel.border(for: country)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initViewModel()
    }
    
    private func initUI() {
        navigationItem.title = NSLocalizedString("CountriesViewControllerTitle", comment: "")
        
        tableView?.register(UINib(nibName: "CountryCell", bundle: Bundle.main), forCellReuseIdentifier: viewModel.cellIdentifier)
    }
    
    private func initViewModel() {
        viewModel.reloadTable = { [weak self]() in
            self?.tableView?.reloadData()
        }
        
        viewModel.requestFailed = { [weak self] (error) in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.tableView?.isHidden = true
                self?.errorLabel?.isHidden = false
                self?.errorLabel?.text = NSLocalizedString("ConnexionError", comment: "")
            }
        }

        viewModel.loadingStatus = { [weak self]() in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                self?.errorLabel?.isHidden = true
                if isLoading {
                    self?.activityIndicator?.startAnimating()
                    self?.tableView?.isHidden = true
                }
                else {
                    self?.activityIndicator?.stopAnimating()
                    self?.tableView?.isHidden = false
                }
            }
        }
        
        viewModel.request()
    }
}


