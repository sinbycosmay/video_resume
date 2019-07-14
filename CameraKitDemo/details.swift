//
//  details.swift
//  CameraKitDemo
//
//  Created by Tanmay Arora on 07/06/19.
//  Copyright © 2019 Wonderkiln. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Google
import FirebaseDatabase
import FirebaseAuth

class details: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var textFiel1: UITextField!
    @IBOutlet weak var textFiel_2: UITextField!

    let piker1 = UIPickerView()
    let piker2 = UIPickerView()
    
    let country = ["Select highest qualification","Post Doctorate","PhD","Bachelors","Masters","Diploma","12th Standard", "10th Standard","8th Standard","5th Standard","Less than 5th Standard"]
    let number = ["Select current country","India","USA","China","Sri Lanka", "Nepal", "Singapore"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view, typically from a nib.
        
        piker1.dataSource = self
        piker1.delegate = self
        
        piker2.dataSource = self
        piker2.delegate = self
        
        
        piker1.tag = 1
        piker2.tag = 2;
        
        
        
        textFiel1.inputView = piker1
        textFiel_2.inputView = piker2
        
        if (textFiel1.text == "" || textFiel_2.text == "" || Name.text == "" ) {
            check_for_empty.isEnabled = false
            check_for_empty.isHidden = true
        }
        else{
            check_for_empty.isEnabled = true
            check_for_empty.isHidden = false
        }
        showToast(message: "Google Sign in successful")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        
        if pickerView == piker1 {
            return country.count
            
        } else if pickerView == piker2{
            return number.count
        }
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == piker1 {
            return country[row]
            
        } else if pickerView == piker2{
            return number[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == piker1 {
            textFiel1.text = country[row]
            //self.view.endEditing(false)
        } else if pickerView == piker2{
            textFiel_2.text = number[row]
            //self.view.endEditing(false)
            if (textFiel1.text == "" || textFiel_2.text == "" || Name.text == "" ) {
                check_for_empty.isEnabled = false
                check_for_empty.isHidden = true
            }
            else{
                check_for_empty.isEnabled = true
                check_for_empty.isHidden = false
            }
        }
    }
    @IBOutlet weak var Name: UITextField!
    
 
    @IBOutlet weak var check_for_empty: UIButton!
    
    @IBAction func continue_button(_ sender: Any) {
        let qualification = textFiel1.text
        UserDefaults.standard.set(qualification, forKey: "qualification")
        print(qualification!)
        let country_of_residence = textFiel_2.text
        UserDefaults.standard.set(country_of_residence, forKey: "country")
        print(country_of_residence!)
        print(Name.text!)
        
        if (textFiel1.text == "" || textFiel_2.text == "" || Name.text == "" ) {
            check_for_empty.isEnabled = false
            check_for_empty.isHidden = true
        }
        else{
            check_for_empty.isEnabled = true
            check_for_empty.isHidden = false
        }
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        //ref.child("users/\(FIRAuth.auth()!.currentUser!.uid)/userBio").setValue(textFiel1.text)
        
        let key = ref.child("users/").child("User Country/Qualification ID").childByAutoId().key
        
        let timestamp = Int(Date().timeIntervalSince1970)
        
        let child = ["key":key,
                     "Qualification": qualification as? String,
                     "Country": country_of_residence as? String,
                     "Full Name": Name.text,
                     "created": "\(timestamp)"] as [String : Any]
        
        ref.child("users").child("chatIds").child(key).setValue(child)
        UserDefaults.standard.set(true, forKey: "details_given")
    }
    

}

