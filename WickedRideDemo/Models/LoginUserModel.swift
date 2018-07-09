//
//  LoginModel.swift
//  WickedRideDemo
//
//  Created by apple on 6/16/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import TwitterKit

struct LoginUserModel {
  var authToken:String?
  var authTokenSecret:String?
  var userId:String?
  var userName:String?
  var screenName:String?
  var profileImageURL:String?
  var profileImageMiniURL:String?
    
  init(session:TWTRSession?) {
        self.authToken = session?.authToken ?? ""
        self.authTokenSecret = session?.authTokenSecret ?? ""
        self.userId = session?.userID ?? ""
        self.userName = session?.userName ?? ""
  }
    
  init(userModel:TWTRUser) {
        self.profileImageMiniURL = userModel.profileImageMiniURL
        self.profileImageURL = userModel.profileImageURL
        self.screenName = userModel.screenName
        self.userId = userModel.userID
        self.userName = userModel.name
  }
    
    func firebaseObjectToInsert() -> [String:String] {
        return ["userId":userId ?? "","userName":userName ?? "","screenName":screenName ?? "","profileImageURL":profileImageURL ?? "","profileImageMiniURL":profileImageMiniURL ?? ""]
    }
}
