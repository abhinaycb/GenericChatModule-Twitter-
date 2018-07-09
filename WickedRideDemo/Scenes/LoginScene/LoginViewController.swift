//
//  ViewController.swift
//  WickedRideDemo
//
//  Created by apple on 6/15/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    @IBOutlet var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
    }
    
    private func setupLoginButton() {
        let logInButton = TWTRLogInButton(logInCompletion: loginViewModel.loginAction)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logInButton)
        logInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100)   .isActive = true
    }
    
}
