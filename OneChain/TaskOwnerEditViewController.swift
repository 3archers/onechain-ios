//
//  TaskOwnerEditViewController.swift
//  OneChain
//
//  Created by Dayang Xiang on 4/7/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskOwnerEditViewController: UIViewController {

    var task: PFObject!
    var members: [PFUser]!
    var ownerRow = 0

    @IBOutlet weak var membersTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        membersTableView.dataSource = self
        membersTableView.delegate = self
        let memberNames = members.map { (PFUser) -> String in
            PFUser.username!
        }
        task["owner"].fetchIfNeededInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if let object = object {
                self.task["owner"] = object as! PFUser
                self.ownerRow = memberNames.indexOf(self.task["owner"].username!!)!
                self.membersTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TaskOwnerEditViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Member Cell",
            forIndexPath: indexPath
            ) as! UserTableViewCell

        cell.user = members[indexPath.row]
        if indexPath.row == ownerRow {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousSelectedCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: ownerRow, inSection: 0)) as! UserTableViewCell
        previousSelectedCell.accessoryType = .None

        let cell = tableView.cellForRowAtIndexPath(indexPath)
        ownerRow = indexPath.row
        task["owner"] = members[ownerRow]
        var logs = task["log"] as! [String]
        logs.append("@\(PFUser.currentUser()!.username!) assigned the task to @\(members[ownerRow].username!).")
        task["log"] = logs
        task.saveInBackground()
        cell?.accessoryType = .Checkmark
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension TaskOwnerEditViewController: UITableViewDelegate {

}
