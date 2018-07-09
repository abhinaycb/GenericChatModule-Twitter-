//
//  AppDelegate.swift
//  WickedRideDemo
//
//  Created by apple on 6/15/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Firebase
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureApp()
        return true
    }
    
    private func configureApp() {
        FirebaseApp.configure()
        NetworkHandler.networkHandler.initiateTwitterSession()
        AppRouter.sharedInstance.loadInitialViewController()
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
      return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
}
