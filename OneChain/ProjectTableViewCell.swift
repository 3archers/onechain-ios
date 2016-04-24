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


    @IBOutlet weak var filesCountLabel: UILabel!
    @IBOutlet weak var postsCountLabel: UILabel!
    @IBOutlet weak var eventsCountLabel: UILabel!
    @IBOutlet weak var tasksCountLabel: UILabel!
    @IBOutlet weak var membersCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    var project: PFObject! {
        didSet {
            nameLabel.text = project["name"] as? String
            descriptionLabel.text = project["description"] as? String

            if project["status"] as! String == "active" {
                statusLabel.text = "Active"
                statusLabel.textColor = UIColor(red:0.09, green:0.63, blue:0.52, alpha:1.0)
            } else {
                statusLabel.text = "Closed"
                statusLabel.textColor = UIColor(red:0.91, green:0.3, blue:0.24, alpha:1.0)
            }

            let members = project["members"] as! [PFUser]
            membersCountLabel.text = String(members.count)

            let tasks = project["tasks"] as! [PFObject]
            tasksCountLabel.text = String(tasks.count)

            let events = project["events"] as! [PFObject]
            eventsCountLabel.text = String(events.count)

            let posts = project["posts"] as! [PFObject]
            postsCountLabel.text = String(posts.count)

            let files = project["files"] as! [PFObject]
            filesCountLabel.text = String(files.count)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
