//
//  SignInViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 3/30/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import MBProgressHUD
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onSignIn(sender: AnyObject) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""

        PFUser.logInWithUsernameInBackground(
            username,
            password: password
        ) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.performSegueWithIdentifier("signin", sender: nil)
            }
        }
    }
}
