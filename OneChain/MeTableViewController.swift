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

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true

        usernameLabel.text = PFUser.currentUser()!.username
        emailLabel.text = PFUser.currentUser()!.email
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        if let imageFile = PFUser.currentUser()!.objectForKey("imageFile") as? PFFile {
            imageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    self.profileImageView.image = UIImage(data: data)
                } else {
                    print(error?.localizedDescription)
                }
            }
        } else {
            profileImageView.image = UIImage(named: "DefaultProfileImage")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
