//
//  FileCreateViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/23/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class FileCreateViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var imageView: UIImageView!

    var project: PFObject!
    var file = PFObject(className: "File")

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.userInteractionEnabled = true
        imageView.image = UIImage(named: "Square")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onImageViewTap(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = UIImagePickerController.isSourceTypeAvailable(.Camera)
            ? UIImagePickerControllerSourceType.Camera
            : UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func onCancel(sender: AnyObject) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSubmit(sender: AnyObject) {
        if imageView.image != nil && !titleField.text!.isEmpty {
            file["author"] = PFUser.currentUser()
            file["title"] = titleField.text
            file["media"] = Utils.getPFFileFromImage(imageView.image)
            project.addObject(file, forKey: "files")
            project.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if success {
                    self.view.endEditing(true)
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
}

extension FileCreateViewController: UINavigationControllerDelegate {

}

extension FileCreateViewController: UIImagePickerControllerDelegate {

    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]
    ) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let resizedImage = Utils.resizeImage(
            originalImage,
            newSize: CGSize(width: imageView.frame.width, height: imageView.frame.height)
        )
        imageView.image = resizedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
}
