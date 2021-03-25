
//MARK: REUSED FROM SELF CREATED CODE

import UIKit

extension UIWindow {
    var topController: UIViewController? {
        rootViewController?.topMostViewController()
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController {
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        else if let tab = presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            
            return tab.topMostViewController()
        }
        else if presentedViewController == nil {
            return self
        }
        
        if let navigation = presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        
        if let tab = presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            
            return tab.topMostViewController()
        }
        
        return presentedViewController!.topMostViewController()
    }
    
}
