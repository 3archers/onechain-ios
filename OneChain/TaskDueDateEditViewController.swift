//
//  TaskDueDateEditViewController.swift
//  OneChain
//
//  Created by Dayang Xiang on 4/7/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskDueDateEditViewController: UIViewController {

    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var task: PFObject!
    var dueDate: NSDate!

    override func viewDidLoad() {
        super.viewDidLoad()

        dueDate = task["due"] as! NSDate
        dueDatePicker.setDate(dueDate, animated: true)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        task["due"] = dueDate
        task.saveInBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onPickDueDate(sender: AnyObject) {
        dueDate = dueDatePicker.date
    }
}
