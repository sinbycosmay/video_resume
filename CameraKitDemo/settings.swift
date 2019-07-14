//
//  settings.swift
//  CameraKitDemo
//
//  Created by Tanmay Arora on 03/07/19.
//  Copyright © 2019 Wonderkiln. All rights reserved.
//

import UIKit

class settings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadeverything()
    }
    
    @IBOutlet weak var phone_number: UILabel!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var label_for_user_id: UILabel!
    @IBOutlet weak var profile_picture: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var qualification: UILabel!
    @IBOutlet weak var country: UILabel!
    
    func loadeverything(){
        phone_number.text = UserDefaults.standard.value(forKey: "Phone_number_verified") as? String
        label_for_user_id.text = UserDefaults.standard.value(forKey: "user_id_final") as? String
        user_name.text = UserDefaults.standard.value(forKey: "username") as? String
        
        qualification.text = UserDefaults.standard.value(forKey: "qualification") as? String
        country.text = UserDefaults.standard.value(forKey: "country") as? String
  
        //let data = try? Data(contentsOf: UserDefaults.standard.url(forKey: "profile_photo")!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        

        profile_picture.image = UIImage(data: UserDefaults.standard.value(forKey: "profile_photo_loaded_data") as! Data)
        
        profile_picture.layer.borderWidth = 1
        profile_picture.layer.masksToBounds = false
        profile_picture.layer.borderColor = UIColor.black.cgColor
        profile_picture.cornerRadius = profile_picture.frame.height/2
        profile_picture.clipsToBounds = true
        
        email.text = "Logged in with: " + String( UserDefaults.standard.value(forKey: "email") as! String)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
