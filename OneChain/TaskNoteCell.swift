//
//  TaskNoteCell.swift
//  OneChain
//
//  Created by Xiaofei Long on 4/16/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

class TaskNoteCell: UITableViewCell {

    @IBOutlet weak var noteTextView: UITextView!

    var task: PFObject! {
        didSet {
            noteTextView.text = task["note"] as? String
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
