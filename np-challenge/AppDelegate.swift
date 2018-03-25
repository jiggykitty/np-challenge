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
        self.window?.rootViewController?.present(splashScreenVC, animated: false, completion: nil)
        
    }
}

