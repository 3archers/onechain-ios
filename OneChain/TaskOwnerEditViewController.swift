//
//  TaskOwnerEditViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/17/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskOwnerEditViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var task: PFObject!
    var project: PFObject!
    var members = [PFUser]()

    var selectedRow: Int?
    var selectedCell: UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        members = project["members"] as! [PFUser]
        if let owner = task["owner"] as? PFUser {
            for (index, member) in members.enumerate() {
                if member.objectId == owner.objectId {
                    selectedRow = index
                    break
                }
            }
        }

        PFObject.fetchAllIfNeededInBackground(members) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.members = objects as! [PFUser]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    override func viewWillDisappear(animated: Bool) {
        if let selectedRow = selectedRow {
            task["owner"] = members[selectedRow]
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
            "User Cell",
            forIndexPath: indexPath
        ) as! UserTableViewCell

        cell.user = members[indexPath.row]
        if indexPath.row == selectedRow {
            cell.accessoryType = .Checkmark
            selectedCell = cell
        } else {
            cell.accessoryType = .None
        }

        return cell
    }
}

extension TaskOwnerEditViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        selectedCell?.accessoryType = .None

        selectedRow = indexPath.row
        selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        selectedCell!.accessoryType = .Checkmark
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
