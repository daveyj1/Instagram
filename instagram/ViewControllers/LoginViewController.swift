//
//  LoginViewController.swift
//  instagram
//
//  Created by Joseph Davey on 1/30/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onLogin(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: (usernameLabel.text)!, password: (passwordLabel.text)!) { (user: PFUser?, NSError) in
            if user != nil {
                print("User is logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newuser = PFUser()
        newuser.username = usernameLabel.text ?? ""
        newuser.password = passwordLabel.text ?? ""
        newuser.signUpInBackground { (success: Bool, NSError) in
            if success {
                print("User created")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(NSError?.localizedDescription)
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
