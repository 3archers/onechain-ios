//
//  ProfileViewController.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/3/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addContactButton: UIButton!

    var showAddContactButton: Bool! = false
    var user: PFUser! = PFUser.currentUser()!
    let currentUser = PFUser.currentUser()!

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = user.username
        emailLabel.text = user.email
        addContactButton.hidden = !showAddContactButton

        profileImageView.userInteractionEnabled = user.objectId == currentUser.objectId
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        if let imageFile = user.objectForKey("imageFile") as? PFFile {
            imageFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    self.profileImageView.image = UIImage(data: data)
                } else {
                    print(error?.localizedDescription)
                }
            }
        } else {
            profileImageView.image = UIImage(named: "DefaultProfileImage")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onProfileImageTap(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func onAddContact(sender: AnyObject) {
        currentUser.addObject(user, forKey: "contacts")
        currentUser.saveInBackground()
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ProfileViewController: UINavigationControllerDelegate {

}

extension ProfileViewController: UIImagePickerControllerDelegate {

    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]
    ) {
        dismissViewControllerAnimated(true, completion: nil)

        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let resizedImage = Utils.resizeImage(
            originalImage,
            newSize: CGSize(
                width: profileImageView.frame.width,
                height: profileImageView.frame.height
            )
        )

        user["imageFile"] = Utils.getPFFileFromImage(resizedImage)
        user.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                self.profileImageView.image = resizedImage
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}
