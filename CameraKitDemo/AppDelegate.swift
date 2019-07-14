//
//  AppDelegate.swift
//  CameraKitDemo
//
//  Created by Adrian Mateoaea on 08/01/2019.
//  Copyright © 2019 Wonderkiln. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    

    var window: UIWindow?
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.isIdleTimerDisabled = true
        FIRApp.configure()
        if UserDefaults.standard.bool(forKey: "userlogin") == true{
            print("App Launched and USER has already logged in, trying to perform segue to next page")
            if UserDefaults.standard.bool(forKey: "details_given") == true{
                if UserDefaults.standard.bool(forKey: "number_provided") == true{
                    DispatchQueue.main.async {
                        self.window?.rootViewController?.performSegue(withIdentifier: "question_page", sender: nil)
                    }
                }
                else {
                    DispatchQueue.main.async {
                    self.window?.rootViewController?.performSegue(withIdentifier: "mobile_verification", sender: nil)
                    }
                }
                
            }
            // Access the storyboard and fetch an instance of the view controller
            else{
            DispatchQueue.main.async {
                self.window?.rootViewController?.performSegue(withIdentifier: "otp", sender: nil)
            }
        }
    }
        if UserDefaults.standard.bool(forKey: "userlogin") == false{
            DispatchQueue.main.async {
                self.window?.rootViewController?.performSegue(withIdentifier: "waittoload", sender: nil)
            }
        }
        return true
    }
    
}
