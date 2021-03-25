//
//  NavigationCoordinator.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit


/// Simple navigation controller,
/// in more complex app, would be more than one coordinator if needed
class NavigationCoordinator {
    private let navigationVC: UINavigationController
    private let window: UIWindow

    public init(window: UIWindow, navigationVC: UINavigationController = UINavigationController()) {
        self.navigationVC = navigationVC
        self.window = window
        
        self.window.rootViewController = self.navigationVC
        self.window.makeKeyAndVisible()
    }
    
    
    public func showCountryList(animated: Bool) {
        navigationVC.pushViewController(setupCountryListController(), animated: animated)
    }
    
    public func showCountryBorders(for country: Country, animated: Bool) {
        navigationVC.pushViewController(setupCountryListController(with: country), animated: animated)
    }
 }

extension NavigationCoordinator {
    private func setupCountryListController(with country: Country? = nil) -> CountryListViewController {
        let countryListVM = CountryListViewModel(country: country)
        
        countryListVM.didSelectCountry = { [weak self] country in
            self?.showCountryBorders(for: country, animated: true)
        }
        
        let countryListVC = CountryListViewController(viewModel: countryListVM)
        
        return countryListVC
    }
}
