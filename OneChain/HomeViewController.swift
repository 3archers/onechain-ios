//
//  HomeViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 3/30/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

let userDidSignOutNotification = "userDidSignOutNotification"

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var projects = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        fetchProjects()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Project Detail" {
            let row = tableView.indexPathForCell(sender as! UITableViewCell)!.row
            let tabBarController = segue.destinationViewController as! UITabBarController
            let tasksViewController = tabBarController.viewControllers![1] as! TasksViewController
            tasksViewController.project = projects[row]
        } else if segue.identifier == "New Project" {
            let navController = segue.destinationViewController as! UINavigationController
            let projectCreateViewController = navController.topViewController
                as! ProjectCreateViewController
            projectCreateViewController.delegate = self
        }
    }

    // MARK: - Actions

    @IBAction func onSignOut(sender: AnyObject) {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName(
            userDidSignOutNotification,
            object: nil
        )
    }

    // MARK: - Helpers

    func fetchProjects() {
        let query = PFQuery(className: "Project")
        query.includeKey("members")
        query.whereKey("members", equalTo: PFUser.currentUser()!)
        query.orderByDescending("createdAt")

        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.projects = objects
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
                // TODO: handle error
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Project Cell",
            forIndexPath: indexPath
        ) as! ProjectTableViewCell

        cell.project = projects[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {

}

extension HomeViewController: ProjectCreateViewControllerDelegate {

    func projectCreateViewController(
        projectCreateViewController: ProjectCreateViewController,
        didCreateNewProject project: PFObject
    ) {
        projects.insert(project, atIndex: 0)
        tableView.reloadData()
    }
}
