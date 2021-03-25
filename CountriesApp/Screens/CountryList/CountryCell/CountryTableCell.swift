//
//  CountryTableCell.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

class CountryTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = nil
        subTitleLabel.text = nil
        imageView?.image = nil
    }
    
    func fill(with viewModel: CountryTableCellViewModel) {
        titleLabel?.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
    }
}
