//
//  TaskTitleCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/16/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskTitleCell: UITableViewCell {

    @IBOutlet weak var titleField: UITextField!

    var task: PFObject! {
        didSet {
            titleField.text = task["title"] as? String
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onTitleFieldEditingChanged(sender: AnyObject) {
        task["title"] = titleField.text
    }
}
