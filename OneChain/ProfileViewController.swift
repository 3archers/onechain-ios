//
//  ProfileViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addContactButton: UIButton!

    var showAddContactButton: Bool!
    var user: PFUser!
    let currentUser = PFUser.currentUser()!

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = user.username
        emailLabel.text = user.email
        addContactButton.hidden = !showAddContactButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onAddContact(sender: AnyObject) {
        currentUser.addObject(user, forKey: "contacts")
        currentUser.saveInBackground()
        dismissViewControllerAnimated(true, completion: nil)
    }
}
