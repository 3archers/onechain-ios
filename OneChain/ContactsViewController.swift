//
//  ContactsViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/2/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ContactsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var users = [PFUser]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        let contacts = PFUser.currentUser()!.objectForKey("contacts") as! [PFUser]
        PFUser.fetchAllInBackground(contacts) { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.users = objects as! [PFUser]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
                // TODO: handle failure
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ContactsViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "User Cell",
            forIndexPath: indexPath
        ) as! UserTableViewCell

        cell.user = users[indexPath.row]
        return cell
    }
}

extension ContactsViewController: UITableViewDelegate {

}
