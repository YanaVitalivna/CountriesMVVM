//
//  Constants.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation

class Constants {
    
    //In full realization base url would be stored in .xcconfig files for each API (development/stage/production APIs)
    //and would changed by selecting different schemes
    
    static var apiURL: URL {
        baseURL.appendingPathComponent(apiVersion)
    }
    
    static var baseURL: URL {
        URL(string: "https://restcountries.eu/rest")!
    }
    
    static var apiVersion: String {
        "/v2"
    }
}
