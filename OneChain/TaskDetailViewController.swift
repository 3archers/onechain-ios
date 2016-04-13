//
//  TaskDetailViewController.swift
//  OneChain
//
//  Created by Dayang Xiang on 4/7/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskDetailViewController: UITableViewController {

    var project: PFObject!
    var task: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case "Name Edit":
                let taskNameEditViewController = segue.destinationViewController
                    as! TaskNameEditViewController
                taskNameEditViewController.task = task
            case "Description Edit":
                let taskDescriptionEditViewController = segue.destinationViewController
                    as! TaskDescriptionEditViewController
                taskDescriptionEditViewController.task = task
            case "Status Edit":
                let taskStatusEditViewController = segue.destinationViewController
                    as! TaskStatusEditViewController
                taskStatusEditViewController.task = task
            case "Owner Edit":
                let taskOwnerEditViewController = segue.destinationViewController
                    as! TaskOwnerEditViewController
                taskOwnerEditViewController.task = task
                taskOwnerEditViewController.members = project["members"] as! [PFUser]
            case "Due Date Edit":
                let taskDueDateEditViewController = segue.destinationViewController
                    as! TaskDueDateEditViewController
                taskDueDateEditViewController.task = task
            default:
                break
        }
    }
}
