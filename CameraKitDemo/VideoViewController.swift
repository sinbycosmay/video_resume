//
//  VideoViewController.swift
//  CameraKitDemo
//
//  Created by Tanmay Arora
//  Copyright © 2019 Tanmay Arora. All rights reserved.
// 2 minute file: format = .mov size: 9.3 MB (Uncompressed)

import UIKit
import AVKit
import CameraKit
import FirebaseStorage
import Photos
import GoogleSignIn
import Google
import FirebaseDatabase
import AudioToolbox
import MobileCoreServices


var question = "Question Text"
class TableViewController: UITableViewController{
    
    @IBAction func drawer(_ sender: Any) {
        
        print("PRESSED SUCCESSFULLY")

    }
    
    
    @IBOutlet weak var add1: UIButton!
    @IBOutlet weak var add2: UIButton!
    @IBOutlet weak var add3: UIButton!
    @IBOutlet weak var add4: UIButton!
    @IBOutlet weak var add5: UIButton!
    @IBOutlet weak var add6: UIButton!
    @IBOutlet weak var add7: UIButton!
    @IBOutlet weak var add8: UIButton!
    
    @IBOutlet weak var q1: UILabel!
    @IBOutlet weak var q2: UILabel!
    @IBOutlet weak var q3: UILabel!
    @IBOutlet weak var q4: UILabel!
    @IBOutlet weak var q5: UILabel!
    @IBOutlet weak var q6: UILabel!
    @IBOutlet weak var q7: UILabel!
    @IBOutlet weak var q8: UILabel!
    
    //var buttonlist: UIButton = [add1 ,add2,add3,add4,add5,add6,add7]
    lazy var question_list = ["Tell me about yourself","Why should I hire you?","What are your strengths and weaknesses?","What are your outside hobbies/interests?","Why do you want to work at our company?","What was the toughest decision you ever had to make?","Who has inspired your life and why?","Tell me about your previous work experience"]
   lazy var label_list = [q1,q2,q3,q4,q5,q6,q7,q8]
    
    @IBAction func add1action(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "add1")

        question = question_list[0]
    }
    
    @IBAction func add2action(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "add2")
        question = question_list[1]
    }
    @IBAction func add3action(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "add3")
        question = question_list[2]
    }
    
    @IBAction func add4action(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "add4")
        question = question_list[3]
    }
    @IBAction func add5action(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "add5")
        question = question_list[4]
    }
    @IBAction func add6action(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "add6")
        question = question_list[5]
    }
    @IBAction func add7action(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "add7")
        question = question_list[6]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "question1_video_added") == true{
            add1.setTitle("✓", for: .normal)
            add1.setTitleColor(UIColor.blue, for: .normal)
        }
        if UserDefaults.standard.bool(forKey: "question2_video_added") == true{
            add2.setTitle("✓", for: .normal)
            add2.setTitleColor(UIColor.blue, for: .normal)
        }
        if UserDefaults.standard.bool(forKey: "question3_video_added") == true{
            add3.setTitle("✓", for: .normal)
            add3.setTitleColor(UIColor.blue, for: .normal)
        }
        if UserDefaults.standard.bool(forKey: "question4_video_added") == true{
            add4.setTitle("✓", for: .normal)
            add4.setTitleColor(UIColor.blue, for: .normal)
        }
        if UserDefaults.standard.bool(forKey: "question5_video_added") == true{
            add5.setTitle("✓", for: .normal)
            add5.setTitleColor(UIColor.blue, for: .normal)
        }
        if UserDefaults.standard.bool(forKey: "question6_video_added") == true{
            add6.setTitle("✓", for: .normal)
            add6.setTitleColor(UIColor.blue, for: .normal)
        }
        if UserDefaults.standard.bool(forKey: "question7_video_added") == true{
            add7.setTitle("✓", for: .normal)
            add7.setTitleColor(UIColor.blue, for: .normal)
        }
        for i in 0..<question_list.count{
            label_list[i]?.text = question_list[i]
        }
        //let currenttitle = add1.currentTitle
    }
    
}

@available(iOS 11.0, *)
class VideoPreviewViewController: UIViewController{
    
    var url: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = self.url {
            let player = AVPlayerViewController()
            player.player = AVPlayer(url: url)
            player.view.frame = self.view.bounds
            
            self.view.addSubview(player.view)
            self.addChild(player)
            
            //player.player?.play()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSave(_ sender: Any) {
        if let url = self.url {
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "compressing", sender: self)
            }
            
            if UserDefaults.standard.bool(forKey: "add1") == true{
                UserDefaults.standard.set(true, forKey: "question1_video_uploading")
            }
            if UserDefaults.standard.bool(forKey: "add2") == true{
                UserDefaults.standard.set(true, forKey: "question2_video_uploading")
            }
            if UserDefaults.standard.bool(forKey: "add3") == true{
                UserDefaults.standard.set(true, forKey: "question3_video_uploading")
            }
            if UserDefaults.standard.bool(forKey: "add4") == true{
                UserDefaults.standard.set(true, forKey: "question4_video_uploading")
            }
            if UserDefaults.standard.bool(forKey: "add5") == true{
                UserDefaults.standard.set(true, forKey: "question5_video_uploading")
            }
            if UserDefaults.standard.bool(forKey: "add6") == true{
                UserDefaults.standard.set(true, forKey: "question6_video_uploading")
            }
            if UserDefaults.standard.bool(forKey: "add7") == true{
                UserDefaults.standard.set(true, forKey: "question7_video_uploading")
            }
            
            UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(handleDidCompleteSavingToLibrary(path:error:contextInfo:)), nil)
            print("SAVEDSAVED")
            
            // Get source video
            let videoToCompress = url
            
            // Declare destination path and remove anything exists in it
            let destinationPath = URL(fileURLWithPath: url.path)
            //try? FileManager.default.removeItem(at: destinationPath)
            
            // Compress
            let cancelable = compressh264VideoInBackground(
                videoToCompress: videoToCompress,
                destinationPath: destinationPath,
                size: (width: 640, height: 480), // nil preserves original,
                //size: (width: 1280, height: 720)
                compressionTransform: .fixForFrontCamera,
                compressionConfig: .defaultConfig,
                completionHandler: { [weak self] path in
                    // use path
                },
                errorHandler: { e in
                    print("Error: ", e)
            },
                cancelHandler: {
                    print("Canceled.")
            }
            )
            cancelable.cancel = true
            
                        
            let user_info = UIDevice.current.name
            
            /*var myCustomViewController: details = details(nibName: nil, bundle: nil)
            var getThatValue = myCustomViewController.textFiel1.text
            var another = myCustomViewController.textFiel_2.text
            */
            UserDefaults.standard.set(url.path, forKey: "link")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "share_social", sender: nil)
            }
            //let timestamp = NSDate().timeIntervalSince1970
            let storageReference = FIRStorage.storage().reference().child(user_info).child(question)
            
            FIRStorage.storage().maxUploadRetryTime = 10
            
            // Start the video storage process
            storageReference.putFile(destinationPath as URL, metadata: nil, completion: { (metadata, error) in
                if error == nil {
                    print("^^^^^Successful video upload of^^^^^^^", question)
                    
                    storageReference.downloadURL(completion: { (destinationPath , error) in
                        print("vid URL: \(String(describing: (destinationPath?.absoluteString)))")
                        
                    })
                    //UserDefaults.standard.set(url.path, forKey: "link")
                    
                    
                    if UserDefaults.standard.bool(forKey: "add1") == true{
                        UserDefaults.standard.set(true, forKey: "question1_video_added")
                    }
                    if UserDefaults.standard.bool(forKey: "add2") == true{
                        UserDefaults.standard.set(true, forKey: "question2_video_added")
                    }
                    if UserDefaults.standard.bool(forKey: "add3") == true{
                        UserDefaults.standard.set(true, forKey: "question3_video_added")
                    }
                    if UserDefaults.standard.bool(forKey: "add4") == true{
                        UserDefaults.standard.set(true, forKey: "question4_video_added")
                    }
                    if UserDefaults.standard.bool(forKey: "add5") == true{
                        UserDefaults.standard.set(true, forKey: "question5_video_added")
                    }
                    if UserDefaults.standard.bool(forKey: "add6") == true{
                        UserDefaults.standard.set(true, forKey: "question6_video_added")
                    }
                    if UserDefaults.standard.bool(forKey: "add7") == true{
                        UserDefaults.standard.set(true, forKey: "question7_video_added")
                    }
                    
                    
                } else {
                    print(error?.localizedDescription ?? "_______ERROR UPLOADING TO FIREBASE_______")
                }
            })
            
            /*if let storageUrl = metadata?.downloadURL()?.absoluteString{
                print(storageUrl)
            }*/
        
        }
        
    }
    
    /*var video_reference: FIRStorageReference{
        return FIRStorage.storage().reference().child("videos")
    }*/
    
    @objc func handleDidCompleteSavingToLibrary(path: String?, error: Error?, contextInfo: Any?) {
        //self.dismiss(animated: true, completion: nil)
    }
}

class VideoSettingsViewController: UITableViewController {
    
    var previewView: CKFPreviewView!
    
    @IBOutlet weak var cameraSegmentControl: UISegmentedControl!
    @IBOutlet weak var flashSegmentControl: UISegmentedControl!
    @IBOutlet weak var gridSegmentControl: UISegmentedControl!
    
    @IBAction func handleCamera(_ sender: UISegmentedControl) {
        if let session = self.previewView.session as? CKFVideoSession {
            session.cameraPosition = sender.selectedSegmentIndex == 0 ? .front : .front
        }
    }
    
    @IBAction func handleFlash(_ sender: UISegmentedControl) {
        if let session = self.previewView.session as? CKFVideoSession {
            let values: [CKFVideoSession.FlashMode] = [.auto, .on, .off]
            session.flashMode = values[sender.selectedSegmentIndex]
        }
    }
    
    @IBAction func handleGrid(_ sender: UISegmentedControl) {
        self.previewView.showGrid = sender.selectedSegmentIndex == 1
    }
    
    @IBAction func handleMode(_ sender: UISegmentedControl) {
        if let session = self.previewView.session as? CKFVideoSession {
            let modes = [(1920, 1080, 30), (1920, 1080, 60), (3840, 2160, 30)]
            let mode = modes[sender.selectedSegmentIndex]
            session.setWidth(mode.0, height: mode.1, frameRate: mode.2)
        }
    }
}

@available(iOS 11.0, *)
class VideoViewController: UIViewController, CKFSessionDelegate{

    //Timer code
    var timer = Timer()
    var totalSecond = 119
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    @objc func updateTime() {
        
        print(timeFormatted(totalSecond))
        
        if (totalSecond >= 0) {
            if timeFormatted(totalSecond)=="0:00"{
                let alert=UIAlertController(title:"Time limit exceeded (2 Minutes)", message: "Discard and Record Again", preferredStyle:UIAlertController.Style.alert )
                
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: {
                    _ in print("TLE")
                }))
                present(alert, animated: true, completion: nil)
            }
            
            totalSecond -= 1
        
        
        }
        else {
            endTimer()
        }
    }
    
    func endTimer() {
        totalSecond = 119
        timer.invalidate()
        
    }
    
    func timeFormatted(_ totalSecond: Int) -> String {
        let minutes: Int = totalSecond / 60
        let seconds: Int = totalSecond % 60
        secondslbl.text = String(format: "%d:%02d",minutes, seconds)
        return String(format: "%d:%02d",minutes, seconds)
    }
    
    @IBOutlet weak var secondslbl: UILabel!
    
    //timer code end
    @IBOutlet weak var zoomLabel: UILabel!
    @IBOutlet weak var captureButton: UIButton!

    
    func didChangeValue(session: CKFSession, value: Any, key: String) {
        if key == "zoom" {
            self.zoomLabel.text = String(format: "%.1fx", value as! Double)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? VideoSettingsViewController {
            vc.previewView = self.previewView
        } else if let nvc = segue.destination as? UINavigationController, let vc = nvc.children.first as? VideoPreviewViewController {
            vc.url = sender as? URL
        }
    }
    
    @IBOutlet weak var previewView: CKFPreviewView! {
        didSet {
            let session = CKFVideoSession()
            session.delegate = self
            self.previewView.autorotate = true
            self.previewView.session = session
            self.previewView.previewLayer?.videoGravity = .resizeAspectFill
        }
        
    }
    
    @IBOutlet weak var panelView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panelView.transform = CGAffineTransform(translationX: 0, y: self.panelView.frame.height + 5)
        self.panelView.isUserInteractionEnabled = false
        question_display.text = question
        
        
    }
    @IBOutlet weak var question_display: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.previewView.session?.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.previewView.session?.stop()
    }
    
    @IBAction func handleSwipeDown(_ sender: Any) {
        self.panelView.isUserInteractionEnabled = false
        self.captureButton.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.2) {
            self.panelView.transform = CGAffineTransform(translationX: 0, y: self.panelView.frame.height)
        }
    }
    
    @IBAction func handleSwipeUp(_ sender: Any) {
        self.panelView.isUserInteractionEnabled = true
        self.captureButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.panelView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    
    @IBOutlet weak var cancel_before_record: UIButton!
    
    @IBAction func handleCapture(_ sender: UIButton) {
        if let session = self.previewView.session as? CKFVideoSession {
            if session.isRecording {
                sender.backgroundColor = UIColor.white.withAlphaComponent(1)
                sender.borderColor = UIColor.white
                session.stopRecording()
                endTimer()
                secondslbl.text = "2:00"
                AudioServicesPlaySystemSound(1118)
            } else {
                AudioServicesPlaySystemSound(1117)
                startTimer()
                cancel_before_record.isHidden = true
                sender.backgroundColor = UIColor.red
                sender.borderColor = UIColor.red
                session.record({ (url) in
                    self.performSegue(withIdentifier: "Preview", sender: url)
                }) { (_) in
                    //
                }
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}
