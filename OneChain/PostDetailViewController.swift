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

    var post: PFObject!
    var comments = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        titleField.enabled = false
        titleField.text = post["title"] as? String

        contentTextView.editable = false
        contentTextView.text = post["content"] as? String

        commentsTableView.dataSource = self
        commentsTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        return tableView.dequeueReusableCellWithIdentifier(
            "Comment Cell",
            forIndexPath: indexPath
        )
    }
}

extension PostDetailViewController: UITableViewDelegate {

}
