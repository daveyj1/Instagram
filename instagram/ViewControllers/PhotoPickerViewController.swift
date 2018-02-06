//
//  PhotoPickerViewController.swift
//  instagram
//
//  Created by Joseph Davey on 2/5/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import Parse

class PhotoPickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var commentLabel: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    let image = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        image.delegate = self
    }
    

    @IBAction func selectImage(_ sender: Any) {
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        let imageData = UIImagePNGRepresentation(myImageView.image!)
        let imageFile = PFFile(name: "Picture", data: imageData!)
        let post = PFObject(className: "Post")
        post["user"] = PFUser.current()
        post["photo"] = imageFile
        post["comment"] = commentLabel.text
        
        post.saveInBackground { (success, error) in
            if success {
                print("Post was saved!")
            } else {
                print("Post could not be saved :(")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = image
        } else {
            print("error getting image")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
