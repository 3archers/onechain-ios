//
//  TaskStatusEditViewController.swift
//  OneChain
//
//  Created by Dayang Xiang on 4/7/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskStatusEditViewController: UIViewController {

    var task: PFObject!

    @IBOutlet weak var statusSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusSwitch.setOn(task["status"] as! String == "active", animated: true)
        statusSwitch.addTarget(self, action: Selector("onSwitch:"), forControlEvents: .ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    func onSwitch(statusSwitch: UISwitch) {
        task["status"] = statusSwitch.on ? "active" : "inactive"
        task.saveInBackground()
    }
}
