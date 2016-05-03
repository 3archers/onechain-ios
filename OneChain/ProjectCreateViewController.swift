//
//  ProjectCreateViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/2/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import MBProgressHUD
import Parse

@objc protocol ProjectCreateViewControllerDelegate {

    optional func projectCreateViewController(
        projectCreateViewController: ProjectCreateViewController,
        didCreateNewProject project: PFObject
    )
}

class ProjectCreateViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var projectNameField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    weak var delegate: ProjectCreateViewControllerDelegate?

    var contacts = [PFUser]()
    var selected: [Bool] = []

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
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        var selectedContacts = [PFUser.currentUser()!]
        for (index, contact) in contacts.enumerate() {
            if (selected[index]) {
                selectedContacts.append(contact)
            }
        }

        let dictionary: [String: AnyObject] = [
            "name": projectNameField.text!,
            "description": descriptionTextView.text,
            "status": "active",
            "members": selectedContacts,
            "tasks": [PFObject](),
            "events": [PFObject](),
            "posts": [PFObject](),
            "files": [PFObject](),
            "log": ["@\(PFUser.currentUser()!.username!) created the project."]
        ]

        let project = PFObject(className: "Project", dictionary: dictionary)
        project.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
            if success {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.view.endEditing(true)
                self.delegate?.projectCreateViewController?(self, didCreateNewProject: project)
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
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        let allContacts = PFUser.currentUser()!.objectForKey("contacts") as! [PFUser]
        PFUser.fetchAllIfNeededInBackground(allContacts) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.contacts = objects as! [PFUser]
                self.selected = [Bool](count: self.contacts.count, repeatedValue: false)
                self.tableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Contact Cell",
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
