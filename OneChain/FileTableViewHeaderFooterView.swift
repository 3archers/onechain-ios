//
//  FileTableViewHeaderFooterView.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/23/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class FileTableViewHeaderFooterView: UITableViewHeaderFooterView {

    var author: PFUser!
    var profileImageView: UIImageView!
    var usernameLabel: UILabel!
    var createdAtLabel: UILabel!

    let viewHeight: CGFloat = 50
    let viewWidth: CGFloat = 320
    let margin: CGFloat = 12

    let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm"
        return formatter
    }()

    var file: PFObject! {
        didSet {
            author = file.objectForKey("author") as! PFUser
            author.fetchIfNeededInBackgroundWithBlock {
                (object: AnyObject?, error: NSError?) -> Void in
                if let object = object {
                    self.author = object as! PFUser
                    self.updateProfileImageView()
                    self.updateUsernameLabel()
                } else {
                    print(error?.localizedDescription)
                }
            }
            updateCreatedAtLabel()
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    func initView() {
        initProfileImageView()
        initUsernameLabel()
        initCreatedAtLabel()

        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(createdAtLabel)
    }

    func initProfileImageView() {
        let imageSize = viewHeight - 2 * margin
        profileImageView = UIImageView(frame: CGRect(
            x: margin,
            y: margin,
            width: imageSize,
            height: imageSize
        ))
        profileImageView.layer.cornerRadius = imageSize / 2
        profileImageView.clipsToBounds = true
    }

    func initUsernameLabel() {
        usernameLabel = UILabel()
        usernameLabel.textAlignment = .Left
        usernameLabel.font = UIFont.systemFontOfSize(14)
    }

    func initCreatedAtLabel() {
        createdAtLabel = UILabel()
        createdAtLabel.textAlignment = .Right
        createdAtLabel.font = UIFont.systemFontOfSize(14)
    }

    func updateProfileImageView() {
        if let imageFile = author.objectForKey("imageFile") as? PFFile {
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

    func updateUsernameLabel() {
        let usernameLabelText = author.username! as NSString
        let usernameLabelSize =
            usernameLabelText.sizeWithAttributes([NSFontAttributeName: usernameLabel.font])
        usernameLabel.frame = CGRect(
            x: viewHeight,
            y: (viewHeight - usernameLabelSize.height) / 2,
            width: usernameLabelSize.width,
            height: usernameLabelSize.height
        )
        usernameLabel.text = author.username
    }

    func updateCreatedAtLabel() {
        let createdAtLabelText = formatter.stringFromDate(file.createdAt!)
        let createdAtLabelSize =
            createdAtLabelText.sizeWithAttributes([NSFontAttributeName: createdAtLabel.font])
        createdAtLabel.frame = CGRect(
            x: viewWidth - margin - createdAtLabelSize.width,
            y: (viewHeight - createdAtLabelSize.height) / 2,
            width: createdAtLabelSize.width,
            height: createdAtLabelSize.height
        )
        createdAtLabel.text = formatter.stringFromDate(file.createdAt!)
    }
}
