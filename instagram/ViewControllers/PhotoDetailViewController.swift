//
//  PhotoDetailViewController.swift
//  instagram
//
//  Created by Joseph Davey on 2/5/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import Parse

class PhotoDetailViewController: UIViewController {
    
    var post: PFObject?
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            if let user = post["user"] as? PFUser {
                userNameLabel.text = user.username
            } else {
                userNameLabel.text = "🤖"
            }
            
            if let comment = post["comment"] as? String {
                commentLabel.text = comment
            }
            
            if let imageFile = post["photo"] as? PFFile {
                imageFile.getDataInBackground(block: {
                    (imageData: Data!, error: Error!) -> Void in
                    if (error == nil) {
                        let image = UIImage(data: imageData)
                        self.postImage.image = image
                    }
                })
            }
            
            if let timestamp = post["date"] as? String{
                timeStampLabel.text = timestamp
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
