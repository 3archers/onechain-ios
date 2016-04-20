//
//  EventTitleCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/19/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class EventTitleCell: UITableViewCell {

    @IBOutlet weak var titleField: UITextField!

    var event: PFObject! {
        didSet {
            titleField.text = event["title"] as? String
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onTitleFieldEditingChanged(sender: AnyObject) {
        event["title"] = titleField.text
    }
}
