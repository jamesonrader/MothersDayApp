//
//  AppDelegate.swift
//  MothersDay2020
//
//  Created by Jameson Rader on 5/7/20.
//  Copyright © 2020 Rader Enterprises. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let nav = UINavigationController.init(rootViewController: OnboardingInvitationViewController())
        nav.navigationBar.isHidden = true
        window?.rootViewController = nav
        
        return true
    }


}

