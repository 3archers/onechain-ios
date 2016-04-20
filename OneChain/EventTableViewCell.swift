//
//  EventTableViewCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/19/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!

    let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd hh:mm"
        return formatter
    }()

    var event: PFObject! {
        didSet {
            titleLabel.text = event["title"] as? String
            locationLabel.text = event["location"] as? String

            if let startTime = event["start_time"] as? NSDate {
                startTimeLabel.text = "Start: \(formatter.stringFromDate(startTime))"
            } else {
                startTimeLabel.text = ""
            }

            if let endTime = event["end_time"] as? NSDate {
                endTimeLabel.text = "End:   \(formatter.stringFromDate(endTime))"
            } else {
                endTimeLabel.text = ""
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
