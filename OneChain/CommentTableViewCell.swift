//
//  CommentTableViewCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/22/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    var comment: PFObject! {
        didSet {
            contentLabel.text = comment["content"] as? String

            profileImageView.layer.cornerRadius = 3
            profileImageView.clipsToBounds = true
            setProfileImage()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Helpers

    func setProfileImage() {
        var author = comment["author"] as! PFUser
        author.fetchIfNeededInBackgroundWithBlock { (object: AnyObject?, error: NSError?) -> Void in
            if let object = object {
                author = object as! PFUser
                if let imageFile = author.objectForKey("imageFile") as? PFFile {
                    imageFile.getDataInBackgroundWithBlock {
                        (data: NSData?, error: NSError?) -> Void in
                        if let data = data {
                            self.profileImageView.image = UIImage(data: data)
                        } else {
                            print(error?.localizedDescription)
                        }
                    }
                } else {
                    self.profileImageView.image = UIImage(named: "DefaultProfileImage")
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}
