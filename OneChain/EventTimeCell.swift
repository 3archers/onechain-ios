//
//  EventTimeCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/19/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

enum EventTimeType {
    case Start, End
}

class EventTimeCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!

    var type: EventTimeType = .Start
    var event: PFObject! {
        didSet {
            switch type {
            case EventTimeType.Start:
                if let time = event["start_time"] as? NSDate {
                    timeLabel.text = "Start: \(formatter.stringFromDate(time))"
                } else {
                    timeLabel.text = "Choose a start time..."
                }
            case EventTimeType.End:
                if let time = event["end_time"] as? NSDate {
                    timeLabel.text = "End: \(formatter.stringFromDate(time))"
                } else {
                    timeLabel.text = "Choose an end time..."
                }
            }
        }
    }

    let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm"
        return formatter
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
