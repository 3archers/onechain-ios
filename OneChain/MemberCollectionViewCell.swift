//
//  MemberCollectionViewCell.swift
//  OneChain
//
//  Created by Difan Chen on 4/20/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class MemberCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var user: PFUser! {
        didSet {
            nameLabel.text = user.username
            profileImageView.layer.cornerRadius = 3
            profileImageView.clipsToBounds = true
            if let imageFile = user.objectForKey("imageFile") as? PFFile {
                imageFile.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                    if let data = data {
                        self.profileImageView.image = UIImage(data: data)
                    } else {
                        print(error?.localizedDescription)
                    }
                })
            } else {
                profileImageView.image = UIImage(named: "DefaultProfileImage")
            }
        }
    }
}
