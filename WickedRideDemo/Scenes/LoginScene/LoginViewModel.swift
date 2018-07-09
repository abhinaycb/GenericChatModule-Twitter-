//
//  LoginViewModel.swift
//  WickedRideDemo
//
//  Created by Abhinay on 6/16/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import TwitterKit
import FirebaseAuth

//MARK: ViewModel for Login
class LoginViewModel: NSObject {
    
    private var model:LoginUserModel?
    
    //MARK: Login Action
    let loginAction:TWTRLogInCompletion = {  session, error in
            if error != nil {
                //Login Failed redirecting to appstore twitter
                print("Failed to login with Twitter / error:", error!.localizedDescription)
                let twitterAppStoreUrlString = URL(string: ApiEndPoints.twitterAppUrl)!
                UIApplication.shared.open(twitterAppStoreUrlString, options: [:], completionHandler: { (flag) in
                    print(flag)
                    //TODO:show error popup
                })
            }else{
                //success Login
                NetworkHandler.networkHandler.userModel = LoginUserModel(session: session)
                //firebase login
                let credential = TwitterAuthProvider.credential(withToken: session?.authToken ?? "", secret: session?.authTokenSecret ?? "")
                print("SuccessFullyLoggedIntoTwitterCallBack")
                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                    if let error = error {
                        //firebase login failed
                        //TODO:show error popup
                        print(error)
                        return
                    }
                    
                    print("FirebaseSuccessFullyLoggedIn")
                    //on success firebase login
                    NetworkHandler.networkHandler.fetchInitialMessages({ chatrooms in
                        if let chatrooms = chatrooms {
                            AppRouter.sharedInstance.loadHomeViewController(chatrooms)
                        }
                    })
                }
            }
    }
}
