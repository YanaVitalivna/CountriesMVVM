//
//  GetCountriesList.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation

class GetCountriesList: BaseRequest<[Country]> {
    init() {
        let url = Constants.apiURL.appendingPathComponent("/all")
        super.init(method: .get, url: url)
    }
}

