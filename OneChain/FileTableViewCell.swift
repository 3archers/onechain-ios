//
//  FileTableViewCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/23/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class FileTableViewCell: UITableViewCell {

    @IBOutlet weak var imageView_: UIImageView!

    var file: PFObject! {
        didSet {
            let media = file.objectForKey("media") as! PFFile
            media.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    self.imageView_.image = UIImage(data: data)
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
