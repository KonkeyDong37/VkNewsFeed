//
//  AuthViewController.swift
//  VkNewsFeed
//
//  Created by Андрей on 06.11.2020.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
    }

    @IBAction func signinTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

