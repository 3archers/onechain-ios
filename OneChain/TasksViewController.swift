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
        tableView.rowHeight = 65
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.title = "Tasks"
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self,
            action: "onNew:"
        )

        PFObject.fetchAllIfNeededInBackground((project["tasks"] as! [PFObject])) {
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

    // MARK: - Action

    func onNew(sender: AnyObject) {
        performSegueWithIdentifier("new task", sender: self)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "new task" {
            let navController = segue.destinationViewController as! UINavigationController
            let taskCreateViewController = navController.topViewController
                as! TaskCreateViewController
            taskCreateViewController.project = project
        } else if segue.identifier == "task detail" {
            let row = tableView.indexPathForCell(sender as! UITableViewCell)!.row
            let taskDetailViewController = segue.destinationViewController
                as! TaskDetailViewController
            taskDetailViewController.task = tasks[row]
            taskDetailViewController.project = project
        }
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
