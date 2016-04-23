//
//  FilesViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class FilesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let headerViewIdentifier = "header view"

    var project: PFObject!
    var files = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 325

        tableView.registerClass(
            FileTableViewHeaderFooterView.self,
            forHeaderFooterViewReuseIdentifier: headerViewIdentifier
        )
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.title = "Files"
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "New",
            style: .Plain,
            target: self,
            action: "onNew:"
        )

        PFObject.fetchAllIfNeededInBackground((project["files"] as! [PFObject])) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.files = objects as! [PFObject]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "New File" {
            let navController = segue.destinationViewController as! UINavigationController
            let fileCreateViewController = navController.topViewController
                as! FileCreateViewController
            fileCreateViewController.project = project
        }
    }

    func onNew(sender: AnyObject) {
        performSegueWithIdentifier("New File", sender: self)
    }
}

extension FilesViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return files.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "File Cell",
            forIndexPath: indexPath
        ) as! FileTableViewCell

        cell.file = files[indexPath.section]
        return cell
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView =
            tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerViewIdentifier)!
            as! FileTableViewHeaderFooterView
        headerView.file = files[section]
        return headerView
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension FilesViewController: UITableViewDelegate {
    
}
