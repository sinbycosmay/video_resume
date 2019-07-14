//
//  ViewControllerMobile.swift
//  Video Interview
//
//  Created by Tanmay Arora on 10/07/19.
//  Copyright © 2019 Wonderkiln. All rights reserved.
//

import UIKit
import Alamofire

class ViewControllerMobile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTargetIsNotEmptyTextFields()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Mobile_number_field: UITextField!
    func setupAddTargetIsNotEmptyTextFields() {
        continue_button_outlet.isHidden = true
        Mobile_number_field.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                    for: .editingChanged)
  
    }
    @objc func textFieldsIsNotEmpty(sender: UITextField) {

        
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        if Mobile_number_field.text?.count == 10{
        guard
            let name = Mobile_number_field.text, !name.isEmpty
            else
        {
            self.continue_button_outlet.isHidden = true
            return
        }
        // enable okButton if all conditions are met
        continue_button_outlet.isHidden = false
                                                }
        else {
            continue_button_outlet.isHidden = true
        }
    }
    
    @IBAction func `continue`(_ sender: Any) {
        
            var fourDigitNumber: String {
                var result = ""
                repeat {
                    // Create a string with a random number 0000000...999999
                    result = String(format:"%06d", arc4random_uniform(900000) + 000001 )
                } while result.count < 6
                print(result)
                UserDefaults.standard.set(result, forKey: "otp_by_phone")
                return result
            }
    
        
        let hit_url = "http://159.89.162.247:8080/walkinapp/api/sms/send"
        
        let phone_number: [Any]  = [
            String(describing: Mobile_number_field.text)
        ]

        
        let parameters: Parameters = [
            "contactNumbers": phone_number,
            "smsType": "transactional",
            "smsContent": "<#> " + "OTP : " + fourDigitNumber + " m2WkfqVgZ5q",
            "sender": "HIRING",
            "campaign": "otp"
        ]
        
        /*Alamofire.request(hit_url,method: .post, parameters: parameters , encoding: JSONEncoding.default, headers: [:]).responseData { (resData) -> Void in
            // Handle the result data i.e. resData
            // ...
        }*/
            
        Alamofire.request(hit_url,method: .post ,parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    @IBOutlet weak var continue_button_outlet: UIButton!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : MobileVerification = segue.destination as! MobileVerification
        DestViewController.labeltext = Mobile_number_field.text!
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
