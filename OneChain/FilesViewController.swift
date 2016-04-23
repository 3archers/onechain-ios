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

    var project: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(
            "File Cell",
            forIndexPath: indexPath
        )
    }
}

extension FilesViewController: UITableViewDelegate {
    
}
