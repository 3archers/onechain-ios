//
//  PostsViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var project: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.title = "Posts"
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
        performSegueWithIdentifier("New Post", sender: self)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "New Post" {
            let navController = segue.destinationViewController as! UINavigationController
            let postCreateViewController = navController.topViewController
                as! PostCreateViewController
            postCreateViewController.project = project
        }
    }
}

extension PostsViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(
            "Post Cell",
            forIndexPath: indexPath
        )
    }
}

extension PostsViewController: UITableViewDelegate {
    
}
