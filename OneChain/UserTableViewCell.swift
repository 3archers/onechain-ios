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

    var user: PFUser! {
        didSet {
            usernameLabel.text = user.username
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
