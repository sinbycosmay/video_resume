//
//  ShareSocial.swift
//  CameraKitDemo
//
//  Created by Tanmay Arora on 21/06/19.
//  Copyright © 2019 Wonderkiln. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
class Share: VideoPreviewViewController{
    @IBAction func shareImageButton(_ sender: UIButton)
    {
        
        let myWebsite = UserDefaults.standard.url(forKey: "link")
        let shareAll = [myWebsite]
        let activityViewController = UIActivityViewController(activityItems: shareAll as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
