//
//  TaskNameEditViewController.swift
//  OneChain
//
//  Created by Dayang Xiang on 4/7/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskNameEditViewController: UIViewController {

    var task: PFObject!

    @IBOutlet weak var taskNameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        taskNameField.delegate = self
        taskNameField.text = "\(task["name"])"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TaskNameEditViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(textField: UITextField) {
        task["name"] = taskNameField.text
        task.saveInBackground()
    }
}
