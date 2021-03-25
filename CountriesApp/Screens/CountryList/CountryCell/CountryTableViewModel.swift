//
//  CountryTableViewModel.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

class CountryTableCellViewModel {
//    //MARK: - Events
    public var didSelectCountry:     ((Country) -> Void)?
    
    //MARK: - public properties
    public var title: String {
        country.nativeName
    }
    
    public var subTitle: String {
        country.name
    }
    
    public var imageURL: URL {
        country.flag
    }
    
    //MARK: - private properties
    private let country: Country
    
    public init(country: Country) {
        self.country = country
    }
}

// litle ui handling in vm. only to make cells using more universal
extension CountryTableCellViewModel: TableCellRepresentable {
    static func registerCell(tableView: UITableView) {
        tableView.register(cellClass: CountryTableCell.self)
    }
    
    func dequeueCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CountryTableCell.self, for: indexPath)
        cell.fill(with: self)
        return cell
    }
    
    func cellSelected() {
        didSelectCountry?(country)
    }
    
    
}
