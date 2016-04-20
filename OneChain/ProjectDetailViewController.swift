//
//  ProjectDetailViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ProjectDetailViewController: UIViewController {

    @IBOutlet weak var projectDescriptionLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var project: PFObject!
    var members = [PFUser]()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.title = "Project Detail"
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .Plain,
            target: self,
            action: "onEdit:")

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()

        projectNameLabel.text = project["name"] as? String
        projectDescriptionLabel.text = project["description"] as? String
        fetchMembers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Edit Project" {
            let navController = segue.destinationViewController as! UINavigationController
            let editViewController = navController.topViewController as! ProjectEditViewController
            editViewController.project = project
        }
    }

    // MARK: - Actions

    func onEdit(sender: UIBarButtonItem) {
        performSegueWithIdentifier("Edit Project", sender: sender)
    }

    // MARK: - Helpers

    func fetchMembers() {
        let members = project["members"] as! [PFUser]
        PFUser.fetchAllIfNeededInBackground(members) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.members = objects as! [PFUser]
                self.collectionView.reloadData()
            } else {
                print(error?.localizedDescription)
                // TODO: handle failure
            }
        }
    }
}

extension ProjectDetailViewController: UICollectionViewDataSource {

    func collectionView(
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return members.count
    }

    func collectionView(
        collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            "Member Cell",
            forIndexPath: indexPath
        ) as! MemberCollectionViewCell
        cell.user = members[indexPath.row]
        return cell
    }
}

extension ProjectDetailViewController: UICollectionViewDelegate {

}
