//
//  CountryListViewController.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {
    
    @IBOutlet private weak var table: UITableView!
    private var viewModel: CountryListViewModel!
    
    private lazy var refreshButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Refresh",
                               style: .plain,
                               target: self,
                               action: #selector(CountryListViewController.reloadData))
    }()
    
    //MARK: - Lifecycle
    required convenience init(viewModel: CountryListViewModel) {
        self.init(nibName: nil, bundle: nil) // test
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setup()
        bindToViewModel()
        reloadData()
    }
    
    func setup() {
        navigationItem.rightBarButtonItem = refreshButton
        viewModel.cellTypes.forEach { $0.registerCell(tableView: table) }
    }
    
    func bindToViewModel() {
        viewModel.didUpdate = { [weak self] _ in
            guard let `self` = self else {
                return
            }
            
            self.title = self.viewModel.title
            self.refreshButton.isEnabled = self.viewModel.isUpdating == false
            self.table.reloadData()
        }
        
        viewModel.didError = { error in
            NotificationAlertController.handle(error: error)
        }
    }
    
    @objc func reloadData() {
        viewModel.reloadData()
    }
}

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countryViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.countryViewModels[indexPath.row].dequeueCell(tableView: tableView, indexPath: indexPath)
    }
}

extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.countryViewModels[indexPath.row].cellSelected()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
