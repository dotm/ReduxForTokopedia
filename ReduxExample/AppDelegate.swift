//
//  AppDelegate.swift
//  ReduxExample
//
//  Created by Yoshua Elmaryono on 30/01/20.
//  Copyright © 2020 Yoshua Elmaryono. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        
        //testMemoryLeak()
        return true
    }
    
    func testMemoryLeak(){
        for i in 0..<40 {
            window?.rootViewController = i.isMultiple(of: 2) ? RootViewController() : CounterViewController()
        }
    }
}

