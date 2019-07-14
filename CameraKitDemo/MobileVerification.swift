//
//  MobileVerification.swift
//  CameraKitDemo
//
//  Created by Tanmay Arora on 03/07/19.
//  Copyright © 2019 Wonderkiln. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Alamofire
import SwiftyJSON


class MobileVerification: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTargetIsNotEmptyTextFields()
        number_display.text = labeltext
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var number_display: UILabel!
    
    @IBOutlet weak var verify_outlet: UIButton!
    
    var labeltext = String()
    
    @IBOutlet weak var OTP_field: UITextField!
    func setupAddTargetIsNotEmptyTextFields() {
        verify_outlet.isHidden = true
        OTP_field.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                      for: .editingChanged)
        
    }
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        
        
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        if OTP_field.text?.count == 6{
            guard
                let name = OTP_field.text, !name.isEmpty
                else
            {
                self.verify_outlet.isHidden = true
                return
            }
            // enable okButton if all conditions are met
            verify_outlet.isHidden = false
        }
        else {
            verify_outlet.isHidden = true
        }
    }
    
    
    @IBAction func verify(_ sender: Any) {
        if OTP_field.text == UserDefaults.standard.value(forKey: "otp_by_phone") as? String{
            print("success")
            UserDefaults.standard.set(number_display.text, forKey: "Phone_number_verified")
            UserDefaults.standard.set(true, forKey: "number_provided")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "question_page", sender: self)
            }
            
            let parameters: Parameters = [
                "phone_no": UserDefaults.standard.value(forKey: "Phone_number_verified")!,
                "userFrom": "Video_resume_iOS",
                "email": UserDefaults.standard.value(forKey: "email")!
            ]
            
            let addUpdateUrl = "http://139.59.68.10/API/AddUpdateUser"
            
            Alamofire.request(addUpdateUrl,method: .post ,parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                if let value = response.result.value {
                    print("JSON: \(value)")// serialized json response
                    let json = JSON(value)
                    
                    print(json["payload"]["uid"].stringValue)
                    let user_id : String = json["payload"]["uid"].stringValue
                    UserDefaults.standard.set(user_id, forKey: "user_id_final")
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                    
                }

            }
        }
        else{
            print("wrong OTP")
            UserDefaults.standard.removeObject(forKey: "otp_by_phone")
        }
        
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
