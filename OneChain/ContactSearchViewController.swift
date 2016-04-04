//
//  ContactSearchViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ContactSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var contacts = [PFUser]()
    var existContactIds: NSSet!

    lazy var searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        searchBar.delegate = self
        searchBar.placeholder = "Search contact by username"
        searchBar.becomeFirstResponder()
        navigationItem.titleView = searchBar

        let existContacts = PFUser.currentUser()!.objectForKey("contacts") as! [PFUser]
        existContactIds = NSSet(array: existContacts.map({ contact in contact.objectId! }))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onCancel(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let profileViewController = segue.destinationViewController as! ProfileViewController
        profileViewController.user = (sender as! UserTableViewCell).user
        profileViewController.showAddContactButton = true
    }
}

extension ContactSearchViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "User Cell",
            forIndexPath: indexPath
        ) as! UserTableViewCell

        cell.user = contacts[indexPath.row]
        return cell
    }
}

extension ContactSearchViewController: UITableViewDelegate {

}

extension ContactSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let query = PFUser.query()
        query?.whereKey("username", containsString: searchBar.text ?? "")
        query?.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.contacts = objects.filter({ object in
                    !self.existContactIds.containsObject(object.objectId!)
                }) as! [PFUser]
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
                // TODO: handle error
            }
        }

        searchBar.resignFirstResponder()
    }
}
