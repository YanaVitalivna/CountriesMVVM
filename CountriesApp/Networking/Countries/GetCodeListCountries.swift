//
//  GetCodeListCountries.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation
import Alamofire

class GetCodeListCountries: BaseRequest<[Country]> {
    init(codes: [String]) {
        let url = Constants.apiURL.appendingPathComponent("alpha")
        let codesParameter = ["codes": codes.joined(separator: ";")]
        
        super.init(method: .get, url: url, params: codesParameter, encoding: URLEncoding.default)
    }
}
