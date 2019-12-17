//
//  AppDelegate.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/16/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setStatusBarBackgroundColor(UIColor.red)
        return true
    }

    func setStatusBarBackgroundColor(_ color: UIColor) {
//        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.statusBarFrame)
            statusBar.backgroundColor = color
            UIApplication.shared.keyWindow?.addSubview(statusBar)
//        } else {
//            ((UIApplication.shared.statusBarView? as AnyObject)).backgroundColor = color
//        }
    }
    
}

