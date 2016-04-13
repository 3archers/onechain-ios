//
//  TaskCreateViewController.swift
//  OneChain
//
//  Created by Dayang Xiang on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskCreateViewController: UIViewController {

    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var ownerPickerView: UIPickerView!

    var dueDate: NSDate!
    var owner = PFUser.currentUser()!
    var project: PFObject!
    var members: [PFUser]!

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.delegate = self
        if (descriptionTextView.text == "") {
            textViewDidEndEditing(descriptionTextView)
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tapGestureRecognizer)

        dueDate = NSDate()

        ownerPickerView.dataSource = self
        ownerPickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions

    @IBAction func onPickDueDate(sender: AnyObject) {
        dueDate = dueDatePicker.date
    }

    @IBAction func onSubmit(sender: AnyObject) {
        let dictionary: [String: AnyObject] = [
            "name": taskNameField.text!,
            "description": descriptionTextView.text,
            "status": "active",
            "owner": owner,
            "due": dueDate!,
            "log": ["@\(PFUser.currentUser()!.username!) assigned the task to @\(owner.username!)."]
        ]

        let task = PFObject(className: "Task", dictionary: dictionary)
        project.addObject(task, forKey: "tasks")
        project.saveInBackground()

        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onCancel(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension TaskCreateViewController: UITextViewDelegate {

    func dismissKeyboard(){
        descriptionTextView.resignFirstResponder()
    }

    func textViewDidEndEditing(textView: UITextView) {
        if (textView.text == "") {
            textView.text = "Description"
            textView.textColor = UIColor.lightGrayColor()
        }
        textView.resignFirstResponder()
    }

    func textViewDidBeginEditing(textView: UITextView){
        if (textView.textColor == UIColor.lightGrayColor()){
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
        textView.becomeFirstResponder()
    }
}

extension TaskCreateViewController: UIPickerViewDelegate {

    func pickerView(
        pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return members[row].username
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        owner = members[row]
    }
}

extension TaskCreateViewController: UIPickerViewDataSource {

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return members.count
    }
}
