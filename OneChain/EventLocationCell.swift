//
//  EventLocationCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/19/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class EventLocationCell: UITableViewCell {

    @IBOutlet weak var locationField: UITextField!

    var event: PFObject! {
        didSet {
            locationField.text = event["location"] as? String
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onLocationFieldEditingChanged(sender: AnyObject) {
        event["location"] = locationField.text
    }
}
