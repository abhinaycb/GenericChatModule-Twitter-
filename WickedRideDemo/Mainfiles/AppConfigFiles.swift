//
//  AppConfigFiles.swift
//  WickedRideDemo
//
//  Created by apple on 7/4/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

struct AppSettings {
    
    var authToken:String! {
        set {
            UserDefaults.standard.set(self.authToken, forKey: "authToken")
        }
        get {
            return UserDefaults.standard.value(forKey: "authToken") as? String ?? ""
        }
    }
    
    var authTokenSecret:String! {
        set {
            UserDefaults.standard.set(self.authToken, forKey: "authTokenSecret")
        }
        get {
            return UserDefaults.standard.value(forKey: "authTokenSecret") as? String ?? ""
        }
    }
    
}
