//
//  CAError.swift // Countries App Error
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation


enum CAError {
    case responseError(String)
    case responseParseError(String)
    case emptyBordersList
}

extension CAError {
    var description: String {
        switch self {
        case .responseError(let desc):
            return desc
            
        case .responseParseError(let desc):
            return desc
            
        case .emptyBordersList:
            return "Selected country has no neighboring countries"
        }
    }
}
