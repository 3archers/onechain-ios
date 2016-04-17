//
//  TaskTableViewCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/17/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    var task: PFObject! {
        didSet {
            titleLabel.text = task["title"] as? String
            if let dueDate = task["due_date"] as? NSDate {
                dueDateLabel.text = formatter.stringFromDate(dueDate)
            } else {
                dueDateLabel.text = ""
            }

            profileImageView.layer.cornerRadius = 1
            profileImageView.clipsToBounds = true
            if let owner = task["owner"] as? PFUser {
                if let imageFile = owner.objectForKey("imageFile") as? PFFile {
                    imageFile.getDataInBackgroundWithBlock {
                        (data: NSData?, error: NSError?) -> Void in
                        if let data = data {
                            self.profileImageView.image = UIImage(data: data)
                        } else {
                            print(error?.localizedDescription)
                        }
                    }
                } else {
                    profileImageView.image = UIImage(named: "DefaultProfileImage")
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
