//
//  ProjectTableViewCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/2/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ProjectTableViewCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!

    var project: PFObject! {
        didSet {
            nameLabel.text = project["name"] as? String
            descriptionLabel.text = project["description"] as? String
            statusLabel.text = project["status"] as? String

            let members = project["members"] as! [PFUser]
            membersLabel.text = members.map({ member in member.username! }).joinWithSeparator(", ")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
