//
//  EditAccountDetails.swift
//  Find_Me
//
//  Created by ramyahar on 3/22/18.
//  Copyright © 2018 ramyahar. All rights reserved.
//

import UIKit
import AWSCore
import AWSS3
import Photos

class EditAccountDetails: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    //Profile Pic
    @IBOutlet weak var importPic: UIImageView!
    
    //User details
    
    //Upload Image to S3
    @IBAction func uploadpic(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        if let image = info [UIImagePickerControllerOriginalImage] as? UIImage
        {
            importPic.image = image
        }
    }
}
