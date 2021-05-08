//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Nouran Adel on 31/12/2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var messageBubble1: UIView!
    @IBOutlet weak var msgbubble: UIView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var leftImageView1: UIImageView!
    @IBOutlet weak var rightImageView1: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        msgbubble.layer.cornerRadius = msgbubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
