//
//  TaskDescriptionEditViewController.swift
//  OneChain
//
//  Created by Dayang Xiang on 4/7/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskDescriptionEditViewController: UIViewController {

    var task: PFObject!
    
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.delegate = self
        descriptionTextView.text = "\(task["description"])"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TaskDescriptionEditViewController: UITextViewDelegate {

    func textViewDidEndEditing(textView: UITextView) {
        task["description"] = descriptionTextView.text
        task.saveInBackground()
    }
}
