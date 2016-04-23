//
//  PostDetailViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class PostDetailViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var commentsTableView: UITableView!

    @IBOutlet weak var commentField: UITextField!

    var post: PFObject!
    var comments = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        titleField.enabled = false
        titleField.text = post["title"] as? String

        contentTextView.editable = false
        contentTextView.text = post["content"] as? String

        commentField.inputAccessoryView = UIView()
        commentField.keyboardDistanceFromTextField = 8

        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        commentsTableView.rowHeight = UITableViewAutomaticDimension
        commentsTableView.estimatedRowHeight = 60

        PFObject.fetchAllIfNeededInBackground((post["comments"] as! [PFObject])) {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.comments = objects as! [PFObject]
                self.commentsTableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onCommentSubmit(sender: AnyObject) {
        let comment = PFObject(className: "Comment")
        comment["content"] = commentField.text
        comment["author"] = PFUser.currentUser()
        post.addObject(comment, forKey: "comments")
        post.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                self.commentField.text = ""
                self.commentField.resignFirstResponder()
                self.comments.insert(comment, atIndex: 0)
                self.commentsTableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}

extension PostDetailViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Comment Cell",
            forIndexPath: indexPath
        ) as! CommentTableViewCell

        cell.comment = comments[indexPath.row]
        return cell
    }
}

extension PostDetailViewController: UITableViewDelegate {

}
