//
//  TaskDueDateCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/16/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskDueDateCell: UITableViewCell {

    @IBOutlet weak var dueDateLabel: UILabel!

    let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm"
        return formatter
    }()

    var task: PFObject! {
        didSet {
            if let dueDate = task["due_date"] as? NSDate {
                dueDateLabel.text = "Due Date: \(formatter.stringFromDate(dueDate))"
            } else {
                dueDateLabel.text = "Add a due date..."
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
