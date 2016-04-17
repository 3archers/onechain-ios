//
//  TaskCreateViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/16/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskCreateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var project: PFObject!

    let task = PFObject(className: "Task")

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

    // MARK: - Action

    @IBAction func onCancel(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSubmit(sender: AnyObject) {
        project.addObject(task, forKey: "tasks")
        project.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                self.view.endEditing(true)
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}

extension TaskCreateViewController: UITableViewDataSource {

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

extension TaskCreateViewController: UITableViewDelegate {


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

extension TaskCreateViewController: UITextViewDelegate {

    func textViewDidChange(textView: UITextView) {
        task["note"] = textView.text
    }
}
