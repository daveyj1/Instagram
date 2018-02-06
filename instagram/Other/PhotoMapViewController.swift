//
//  PhotoMapViewController.swift
//  instagram
//
//  Created by Joseph Davey on 2/4/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editiedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        let imageData = UIImagePNGRepresentation(originalImage)
        let imageFile = PFFile(name: "Picture", data: imageData!)
        
        let post = PFObject(className: "Post")
        post["user"] = PFUser.current()
        post["photo"] = imageFile
        print("Post added")
        
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
