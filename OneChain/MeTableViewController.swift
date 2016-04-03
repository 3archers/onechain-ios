//
//  MeTableViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/2/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class MeTableViewController: UITableViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true

        usernameLabel.text = PFUser.currentUser()!.username
        emailLabel.text = PFUser.currentUser()!.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
