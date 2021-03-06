//
//  SignUpViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 3/30/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.email = emailField.text
        newUser["contacts"] = [PFUser]()

        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.performSegueWithIdentifier("signup", sender: nil)
                print("User signed up")
            }
        }
    }
}
