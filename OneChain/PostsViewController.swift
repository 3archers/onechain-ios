//
//  PostsViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.title = "Posts"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
