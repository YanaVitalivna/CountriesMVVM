//
//  Country.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation

class Country: Decodable {
    let name: String
    let nativeName: String
    let borders: [String]
    let flag: URL
}
