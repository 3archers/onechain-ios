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
    var events = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 65
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

        let events = project["events"] as! [PFObject]
        PFObject.fetchAllIfNeededInBackground(events) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.events = objects as! [PFObject]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
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
        } else if segue.identifier == "event detail" {
            let row = tableView.indexPathForCell(sender as! UITableViewCell)!.row
            let eventDetailViewController = segue.destinationViewController
                as! EventDetailViewController
            eventDetailViewController.event = events[row]
            eventDetailViewController.project = project
        }
    }
}

extension EventsViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Event Cell",
            forIndexPath: indexPath
        ) as! EventTableViewCell

        cell.event = events[indexPath.row]
        return cell
    }
}

extension EventsViewController: UITableViewDelegate {
    
}
