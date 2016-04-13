//
//  TasksViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var project: PFObject!
    var tasks = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.title = "Tasks"
        let newButton = UIBarButtonItem(
            title: "New",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "onNewButtonTouchUp:"
        )
        tabBarController?.navigationItem.rightBarButtonItem = newButton

        let tasks = project.objectForKey("tasks") as! [PFObject]
        PFObject.fetchAllIfNeededInBackground(tasks) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.tasks = objects as! [PFObject]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newTask" {
            let navController = segue.destinationViewController as! UINavigationController
            let taskCreateViewController = navController.topViewController
                as! TaskCreateViewController
            taskCreateViewController.project = project
            taskCreateViewController.members = project["members"] as! [PFUser]
        } else if segue.identifier == "taskDetail" {
            let indexPath = tableView.indexPathForCell(sender as! TaskTableViewCell)!
            let taskDetailViewController = segue.destinationViewController
                as! TaskDetailViewController
            taskDetailViewController.project = project
            taskDetailViewController.task = tasks[indexPath.row]
        }
    }

    // MARK: - Actions

    func onNewButtonTouchUp(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("newTask", sender: nil)
    }
}

extension TasksViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Task Cell",
            forIndexPath: indexPath
        ) as! TaskTableViewCell

        cell.task = tasks[indexPath.row]
        return cell
    }
}

extension TasksViewController: UITableViewDelegate {

}
