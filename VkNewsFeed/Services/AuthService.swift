//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by Андрей on 07.11.2020.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
    func authServiceSholdShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7652909"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline", "wall", "friends"]

        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in

            switch state {
            case .initialized:
                print("init")
                VKSdk.authorize(scope)
            case .authorized:
                print("auth")
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFail()
                
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceSholdShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
       
    }
}
