//
//  ProjectCreateViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/2/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ProjectCreateViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var projectNameField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var contacts = [PFUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        fetchContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onSubmit(sender: AnyObject) {
        var selectedContacts = [PFUser]()
        if let indexPaths = tableView.indexPathsForSelectedRows {
            for indexPath in indexPaths {
                selectedContacts.append(contacts[indexPath.row])
            }
        }
        selectedContacts.append(PFUser.currentUser()!)
        let dictionary: [String: AnyObject] = [
            "name": projectNameField.text!,
            "description": descriptionTextView.text,
            "status": "active",
            "members": selectedContacts,
            "log": ["@\(PFUser.currentUser()!.username!) created the project."]
        ]
        let project = PFObject(className: "Project", dictionary: dictionary)
        project.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
            if success {
                self.view.endEditing(true)
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print(error?.localizedDescription)
                // TODO: handle failure
            }
        }
    }

    @IBAction func onCancel(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Helpers

    func fetchContacts() {
        let allContacts = PFUser.currentUser()!.objectForKey("contacts") as! [PFUser]
        PFUser.fetchAllIfNeededInBackground(allContacts) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.contacts = objects as! [PFUser]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
                // TODO: handle failure
            }
        }
    }
}

extension ProjectCreateViewController: UITableViewDelegate {

}

extension ProjectCreateViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .None
        cell.textLabel?.text = "\(contacts[indexPath.row].username!)"
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = UITableViewCellAccessoryType.None
    }
}
