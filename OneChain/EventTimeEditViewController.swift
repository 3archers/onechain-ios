//
//  EventTimeEditViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/19/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class EventTimeEditViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!

    var event: PFObject!
    var timeField: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let time = event[timeField] as? NSDate {
            datePicker.setDate(time, animated: true)
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        event[timeField] = datePicker.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
