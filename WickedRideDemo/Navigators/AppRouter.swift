//
//  AppRouter.swift
//  WickedRideDemo
//
//  Created by Abhinay on 6/16/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit

class AppRouter: NSObject {
    static let sharedInstance = AppRouter()
  
    //MARK: Properties
    var rootNavigationController:UINavigationController?
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    lazy var loginViewController:LoginViewController = {
        return (storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController)
    }()
    lazy var homeViewController:ChatRoomsViewController = {
        return (storyboard.instantiateViewController(withIdentifier: "ChatRoomsViewController") as! ChatRoomsViewController)
    }()
    
    lazy var chatDetailViewController = {
        return (storyboard.instantiateViewController(withIdentifier: "ChatDetailViewController") as! ChatDetailViewController)
    }()
    
    //MARK: Loading 1st LoginViewController
    func loadInitialViewController() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            rootNavigationController = UINavigationController(rootViewController: loginViewController)
            rootNavigationController?.navigationBar.isHidden = true
            appDelegate.window?.rootViewController = rootNavigationController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    //MARK: Load HomeViewController
    func loadHomeViewController(_ chatroomModel:ChatRoomsModel) {
        homeViewController.homeViewModel = HomeViewModel(chatroomModel: chatroomModel)
        DispatchQueue.main.async {
            self.rootNavigationController?.pushViewController(self.homeViewController, animated: true)
        }
    }
    
    //MARK: Load Chat Detail ViewController
    func loadChatDetailViewController(withData:ChatRoom) {
        chatDetailViewController.viewModel = ChatDetailViewModel(chatroom: withData)
        self.rootNavigationController?.pushViewController(chatDetailViewController, animated: true)
    }
    
    //MARK: Pop to ChatRoomsView Controller
    func popToChatRoomsViewController() {
        self.rootNavigationController?.popViewController(animated: true)
    }
}

