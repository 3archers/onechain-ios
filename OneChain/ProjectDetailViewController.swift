//
//  ProjectDetailViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ProjectDetailViewController: UIViewController {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!

    var project: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.navigationItem.title = "Project Detail"
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .Plain,
            target: self,
            action: "onEdit:")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        projectNameLabel.text = project["name"] as? String
        projectDescriptionLabel.text = project["description"] as? String
        fetchMembers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Edit Project" {
            let navController = segue.destinationViewController as! UINavigationController
            let editViewController = navController.topViewController as! ProjectEditViewController
            editViewController.project = project
        }
    }

    // MARK: - Actions

    func onEdit(sender: UIBarButtonItem) {
        performSegueWithIdentifier("Edit Project", sender: sender)
    }

    // MARK: - Helpers

    func fetchMembers() {
        let currentMembers = project["members"] as! [PFUser]
        PFUser.fetchAllIfNeededInBackground(currentMembers) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                let members = objects as! [PFUser]
                self.membersLabel.text =
                    members.map({ member in member.username! }).joinWithSeparator(", ")
            } else {
                print(error?.localizedDescription)
                // TODO: handle failure
            }
        }
    }
}
