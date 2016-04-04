//
//  ProjectCreateViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/2/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ProjectCreateViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var projectNameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onSubmit(sender: AnyObject) {
        let dictionary: [String: AnyObject] = [
            "name": projectNameField.text!,
            "description": descriptionTextView.text,
            "status": "active",
            "members": [PFUser.currentUser()!],
            "tasks": [PFObject](),
            "log": ["@\(PFUser.currentUser()!.username!) created the project."]
        ]

        let project = PFObject(className: "Project", dictionary: dictionary)
        project.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
            if success {
                self.view.endEditing(true)
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print(error?.localizedDescription)
                // TODO: handle failure
            }
        }
    }

    @IBAction func onCancel(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
}
