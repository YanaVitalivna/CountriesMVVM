//
//  TableCellRepresentable.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

protocol TableCellRepresentable {
    static func registerCell(tableView: UITableView)
    func dequeueCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func cellSelected()
}
