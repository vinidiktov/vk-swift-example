//
//  ViewController.swift
//  VK_Swift_Example
//
//  Created by Alex Vinidiktov on 25.10.2020.
//

import UIKit
import VK_ios_sdk

class ViewController: UIViewController {
    let VK_APP_ID = "7639237"
    
    @IBAction func authotizeButtonClick(_ sender: UIButton) {
        let SCOPE = ["wall", "photos", "email", "friends"]
        VKSdk.authorize(SCOPE)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sdkInstance = VKSdk.initialize(withAppId: self.VK_APP_ID)
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
        
        VKSdk.wakeUpSession(nil) { (state: VKAuthorizationState, error: Error?)   in
            if state == .authorized {
                print ("User is authorized")
            } else if ((error) != nil) {
                print ("wakeUpSession error: \(error!.localizedDescription)")
            }
            print ("state \(state)")
        }
    }


}

extension ViewController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if ((result.token) != nil) {
            print ("user token: \(result.token!)")
        } else if ((result.error) != nil) {
            print ("Access denied \(result.error!)")
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print ("User authorization failed")
        self.navigationController?.popToRootViewController(animated: false)
    }
}

extension ViewController: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.navigationController?.topViewController?.present(controller, animated: true, completion: {
        })
//        if (self.presentedViewController != nil) {
//            self.dismiss(animated: true, completion: {
//                self.present(controller, animated: true, completion: {
//                })
//            })
//        } else {
//            self.present(controller, animated: true, completion: {
//            })
//        }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        //
    }
    
    
}

