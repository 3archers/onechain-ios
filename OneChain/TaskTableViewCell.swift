//
//  TaskTableViewCell.swift
//  OneChain
//
//  Created by Dayang Xiang on 4/5/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!

    var task: PFObject! {
        didSet {
            taskNameLabel.text = task["name"] as? String
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
