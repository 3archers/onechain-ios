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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
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
            taskCreateViewController.members = project.valueForKey("members") as! [PFUser]
        }
    }

    // MARK: - Actions

    func onNewButtonTouchUp(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("newTask", sender: nil)
    }
}

extension TasksViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(
            "Task Cell",
            forIndexPath: indexPath
        )
    }
}

extension TasksViewController: UITableViewDelegate {

}
