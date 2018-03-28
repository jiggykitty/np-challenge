//
//  AppDelegate.swift
//  np-challenge
//
//  Created by Cagri Sahan on 3/25/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var launchFromTerminated = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if launchFromTerminated {
            showSplashScreen()
            launchFromTerminated = false
        }
    }
    

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func showSplashScreen() {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        let splashScreenVC = storyboard.instantiateViewController(withIdentifier: "SplashScreenVC")
        self.topController().present(splashScreenVC, animated: false, completion: nil)
        
    }
    
    func topController(_ parent: UIViewController? = nil) -> UIViewController {
        if let vc = parent {
            if let tab = vc as? UITabBarController, let selected = tab.selectedViewController {
                return topController(selected)
            } else if let nav = vc as? UINavigationController, let top = nav.topViewController {
                return topController(top)
            } else if let presented = vc.presentedViewController {
                return topController(presented)
            } else {
                return vc
            }
        } else {
            print("lala")
            return topController(UIApplication.shared.keyWindow!.rootViewController!)
        }
    }
}

