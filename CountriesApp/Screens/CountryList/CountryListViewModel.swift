//
//  CountryListViewModel.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation

class CountryListViewModel {
    
    //MARK: - public action handlers
    public var didError: ((CAError) -> Void)?
    public var didUpdate: ((CountryListViewModel) -> Void)?
    public var didSelectCountry: ((Country) -> Void)?
    
    //MARK: - public properties
    public let cellTypes: [TableCellRepresentable.Type] = [CountryTableCellViewModel.self]
    public private(set) var countryViewModels: [CountryTableCellViewModel] = []
    public private(set) var isUpdating: Bool = false {
        didSet {
            didUpdate?(self)
        }
    }
    
    public var title: String {
        if isUpdating {
            return "Updating..."
        }
        else if let name = self.country?.name {
            return name.capitalized + " borders: \(countryViewModels.count)"
        }
        else {
            return "Total: \(self.countryViewModels.count)"
        }
    }
    
    //MARK: - privat properties
    private var country: Country?
    
    //
    init(country: Country? = nil) {
        self.country = country
    }
    
    //MARK: public methods
    public func reloadData() {
        if let country = country {
            loadBorders(for: country)
        }
        else {
            loadAllCountries()
        }
    }
    
    //MARK: - private methods
    private func loadAllCountries() {
        isUpdating = true
        
        GetCountriesList().success({ [weak self] (countries) in
            guard let `self` = self else {
                return
            }
            
            self.countryViewModels = countries.map { self.viewModel(for: $0) }
            self.isUpdating = false
        })
        .failure { [weak self] (error) in
            self?.didError?(error)
            self?.isUpdating = false
        }
        .execute()
    }
    
    private func loadBorders(for country: Country) {
        isUpdating = true
        
        GetCodeListCountries(codes: country.borders).success({ [weak self] (countries) in
            guard let `self` = self else {
                return
            }
            
            self.countryViewModels = countries.map { self.viewModel(for: $0) }
            self.isUpdating = false
        })
        .failure { [weak self] (error) in
            self?.didError?(error)
            self?.isUpdating = false
        }
        .execute()
    }
}

extension CountryListViewModel {
    func viewModel(for country: Country) -> CountryTableCellViewModel {
        let vm = CountryTableCellViewModel(country: country)
        
        vm.didSelectCountry = { [weak self] country in
            guard country.borders.isEmpty == false else {
                NotificationAlertController.handle(error: .emptyBordersList)
                return
            }
            
            self?.didSelectCountry?(country)
        }
        
        return vm
    }
}
