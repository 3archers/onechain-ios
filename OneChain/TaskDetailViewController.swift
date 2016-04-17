//
//  TaskDetailViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var project: PFObject!
    var task: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        task.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Due Date" {
            let dueDateEditViewController = segue.destinationViewController
                as! TaskDueDateEditViewController
            dueDateEditViewController.task = task
        } else if segue.identifier == "Owner" {
            let ownerEditViewController = segue.destinationViewController
                as! TaskOwnerEditViewController
            ownerEditViewController.task = task
            ownerEditViewController.project = project
        }
    }
}

extension TaskDetailViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "Title Cell",
                forIndexPath: indexPath
            ) as! TaskTitleCell
            cell.task = task
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "Note Cell",
                forIndexPath: indexPath
            ) as! TaskNoteCell
            cell.task = task
            cell.noteTextView.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "Owner Cell",
                forIndexPath: indexPath
            ) as! TaskOwnerCell
            cell.task = task
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "Due Date Cell",
                forIndexPath: indexPath
            ) as! TaskDueDateCell
            cell.task = task
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension TaskDetailViewController: UITableViewDelegate {


    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(
        tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath
    ) -> CGFloat {
        return indexPath.section == 1 ? 100 : 44
    }
}


extension TaskDetailViewController: UITextViewDelegate {

    func textViewDidChange(textView: UITextView) {
        task["note"] = textView.text
    }
}
