//
//  AppDelegate.swift
//  CountriesApp
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow = UIWindow()
    var navigationCoordinator: NavigationCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        navigationCoordinator = NavigationCoordinator(window: window)
        navigationCoordinator.showCountryList(animated: false)
        
        return true
    }
}

