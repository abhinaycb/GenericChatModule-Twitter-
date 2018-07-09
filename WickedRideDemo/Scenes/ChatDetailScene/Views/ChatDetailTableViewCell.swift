//
//  ChatDetailTableViewCell.swift
//  WickedRideDemo
//
//  Created by apple on 6/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ChatDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var senderImage: UIView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ model:Message) {
        nameLabel.text = model.message_create?.message_data?.text
        timeLabel.text = makeFormatedStringFor(timeStamp: Double(model.created_timestamp ?? "0")!)
    }
    
}
