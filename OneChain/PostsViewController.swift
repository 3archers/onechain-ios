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
    var posts = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 65
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

        PFObject.fetchAllIfNeededInBackground((project["posts"] as! [PFObject])) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.posts = objects as! [PFObject]
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
        performSegueWithIdentifier("New Post", sender: self)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "New Post" {
            let navController = segue.destinationViewController as! UINavigationController
            let postCreateViewController = navController.topViewController
                as! PostCreateViewController
            postCreateViewController.project = project
        } else if segue.identifier == "Detail" {
            let row = tableView.indexPathForCell(sender as! UITableViewCell)!.row
            let postDetailViewController = segue.destinationViewController
                as! PostDetailViewController
            postDetailViewController.post = posts[row]
        }
    }
}

extension PostsViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Post Cell",
            forIndexPath: indexPath
        ) as! PostTableViewCell

        cell.post = posts[indexPath.row]
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    
}
