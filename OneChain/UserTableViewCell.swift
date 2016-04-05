//
//  UserTableViewCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/2/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    var user: PFUser! {
        didSet {
            usernameLabel.text = user.username

            profileImageView.layer.cornerRadius = 1
            profileImageView.clipsToBounds = true
            if let imageFile = user.objectForKey("imageFile") as? PFFile {
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
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
