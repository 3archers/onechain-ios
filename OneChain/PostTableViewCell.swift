//
//  PostTableViewCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/22/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    var post: PFObject! {
        didSet {
            titleLabel.text = post["title"] as? String
            commentCountLabel.text = "Comments: \((post["comments"] as! [PFObject]).count)"

            profileImageView.layer.cornerRadius = 4
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
        var author = post["author"] as! PFUser
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
