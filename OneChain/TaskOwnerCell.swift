//
//  TaskOwnerCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/17/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskOwnerCell: UITableViewCell {

    @IBOutlet weak var ownerLabel: UILabel!

    var task: PFObject! {
        didSet {
            if let owner = task["owner"] as? PFUser {
                ownerLabel.text = "Owner: \(owner.username!)"
            } else {
                ownerLabel.text = "Choose an owner..."
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
