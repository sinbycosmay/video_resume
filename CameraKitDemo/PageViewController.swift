//
//  PageViewController.swift
//  CameraKitDemo
//
//  Created by Tanmay Arora on 28/05/19.
//  Copyright © 2019 Wonderkiln. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import FirebaseStorage
import FirebaseAuth
import Firebase



class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, GIDSignInUIDelegate, GIDSignInDelegate {
    

    
    lazy var orderedViewControllers:  [UIViewController] = {
        return [self.newvc(viewController: "page1"),
                self.newvc(viewController: "page2"),
                self.newvc(viewController: "page3"),
                self.newvc(viewController: "page4"),
                self.newvc(viewController: "page5")]
    }()
    
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "userlogin") == true{
            performSegue(withIdentifier: "otp", sender: PageViewController.self)
        }
        
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        self.delegate = self
        configurePageControl()
        
        //code for Googlesignin
        var error: NSError?
        GGLContext.sharedInstance()?.configureWithError(&error)
        if error != nil{
            print(error ?? "some error")
            return
        }
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        print(UserDefaults.self)
    }//ViewDidLoad End
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        print(user.profile.email)
        print(user.profile.name)
        print(user.profile.imageURL(withDimension: 400))
        print(user.userID) //for CLIENT SIDE USE
        print(user.authentication.idToken) //TO SEND TO SERVER
        //print(passwd.self)
        UserDefaults.standard.set(String(user.userID), forKey: "user_ID")
        UserDefaults.standard.set(user.profile.name, forKey: "username")
        UserDefaults.standard.set(user.profile.imageURL(withDimension: 95), forKey: "profile_photo")
        UserDefaults.standard.set(user.profile.email, forKey: "email")
        let data = try? Data(contentsOf: UserDefaults.standard.url(forKey: "profile_photo")!)
        UserDefaults.standard.set(data, forKey: "profile_photo_loaded_data")
        
        performSegue(withIdentifier: "otp", sender: signIn)
        UserDefaults.standard.set(true, forKey: "userlogin")
        //FIRStorage.storage().reference().child(user.profile.email)
        
        FIRAuth.auth()!.createUser(withEmail: user.profile.email, password: user.userID) { authResult, error in
            // ...
        }
        
    }
    //Code for Google Sign in end
    
    func configurePageControl(){
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
        pageControl.isUserInteractionEnabled = false
    }
    
    func newvc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex
            else{
                //return orderedViewControllers.last
                return nil
        }
        
        guard orderedViewControllers.count > nextIndex else{
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!  
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0
            else{
                //return orderedViewControllers.last
                return nil
        }
        
        guard orderedViewControllers.count > previousIndex else{
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }

}
