//
//  EventCreateViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/19/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class EventCreateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var project: PFObject!

    let event = PFObject(className: "Event")

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
        if segue.identifier == "Time" {
            let timeEditViewController = segue.destinationViewController
                as! EventTimeEditViewController
            let row = tableView.indexPathForCell(sender as! UITableViewCell)!.row
            timeEditViewController.timeField = row == 0 ? "start_time" : "end_time"
            timeEditViewController.event = event
        }
    }

    // MARK: - Actions

    @IBAction func onCancel(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSubmit(sender: AnyObject) {
        project.addObject(event, forKey: "events")
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

extension EventCreateViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 ? 2 : 1
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
            ) as! EventTitleCell
            cell.event = event
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "Note Cell",
                forIndexPath: indexPath
            ) as! EventNoteCell
            cell.event = event
            cell.noteTextView.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "Location Cell",
                forIndexPath: indexPath
            ) as! EventLocationCell
            cell.event = event
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "Time Cell",
                forIndexPath: indexPath
            ) as! EventTimeCell
            cell.type = indexPath.row == 0 ? .Start : .End
            cell.event = event
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension EventCreateViewController: UITableViewDelegate {

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

extension EventCreateViewController: UITextViewDelegate {

    func textViewDidChange(textView: UITextView) {
        event["note"] = textView.text
    }
}
