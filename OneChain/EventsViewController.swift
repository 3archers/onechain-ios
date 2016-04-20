//
//  EventsViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class EventsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var project: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.title = "Events"
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "New",
            style: .Plain,
            target: self,
            action: "onNew:"
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func onNew(sender: AnyObject) {
        performSegueWithIdentifier("new event", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "new event" {
            let navController = segue.destinationViewController as! UINavigationController
            let eventCreateViewController = navController.topViewController
                as! EventCreateViewController
            eventCreateViewController.project = project
        }
    }
}

extension EventsViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(
            "Event Cell",
            forIndexPath: indexPath
        )
    }
}

extension EventsViewController: UITableViewDelegate {
    
}
