//
//  PostCreateViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/22/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import MBProgressHUD
import Parse

class PostCreateViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!

    var project: PFObject!
    var post = PFObject(className: "Post")

    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextView.delegate = self
        contentTextView.text = "Content"
        contentTextView.textColor = UIColor(white: 0, alpha: 0.25)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onCancel(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSubmit(sender: AnyObject) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        post["title"] = titleField.text
        post["content"] = contentTextView.text
        post["author"] = PFUser.currentUser()
        post["comments"] = [PFObject]()

        project.addObject(post, forKey: "posts")
        project.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.view.endEditing(true)
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}

extension PostCreateViewController: UITextViewDelegate {

    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor != UIColor.blackColor() {
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
    }

    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            contentTextView.text = "Content"
            contentTextView.textColor = UIColor(white: 0, alpha: 0.25)
        }
    }
}
