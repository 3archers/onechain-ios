//
//  EventNoteCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/19/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class EventNoteCell: UITableViewCell {

    @IBOutlet weak var noteTextView: UITextView!

    var event: PFObject!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
