//
//  ProjectEditViewController.swift
//  OneChain
//
//  Created by Difan Chen on 4/20/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ProjectEditViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!

    var project: PFObject!
    var selected: [Bool] = []
    var contacts = [PFUser]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        descriptionTextView.text = project["description"] as? String
        nameTextField.text = project["name"] as? String
    }

    override func viewWillAppear(animated: Bool) {
        fetchContacts()
    }

    // MARK: - Actions

    @IBAction func onSave(sender: AnyObject) {
        project["name"] = nameTextField.text
        project["description"] = descriptionTextView.text

        for (index, contact) in contacts.enumerate() {
            if selected[index] {
                project.addObject(contact, forKey: "members")
            }
        }

        project.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                self.view.endEditing(true)
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    @IBAction func onCancel(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Helpers

    func fetchContacts() {
        let contacts = PFUser.currentUser()!.objectForKey("contacts") as! [PFUser]
        PFUser.fetchAllIfNeededInBackground(contacts) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.contacts = objects as! [PFUser]
                self.filterContacts()
                self.selected = [Bool](count: contacts.count, repeatedValue: false)
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
                // TODO: handle failure
            }
        }
    }

    func filterContacts() {
        let existMembers = project["members"] as! [PFUser]
        let existMemberIds = existMembers.map({ member in member.objectId! })
        contacts = contacts.filter({ contact in !existMemberIds.contains(contact.objectId!) })
    }
}

extension ProjectEditViewController: UITableViewDelegate {

}

extension ProjectEditViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Project Edit Contact Cell",
            forIndexPath: indexPath
        ) as! UserTableViewCell

        cell.user = contacts[indexPath.row]
        cell.accessoryType = selected[indexPath.row] ? .Checkmark : .None
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selected[indexPath.row] = !selected[indexPath.row]

        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = selected[indexPath.row] ? .Checkmark : .None

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
