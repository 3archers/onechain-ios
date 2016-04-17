//
//  TaskDueDateEditViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/16/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskDueDateEditViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!

    var task: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let dueDate = task["due_date"] as? NSDate {
            datePicker.setDate(dueDate, animated: true)
        }
    }

    override func viewWillDisappear(animated: Bool) {
        task["due_date"] = datePicker.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
