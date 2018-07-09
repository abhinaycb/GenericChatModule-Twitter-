//
//  ChatDetailRightTableViewCell.swift
//  WickedRideDemo
//
//  Created by apple on 6/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ChatDetailRightTableViewCell: UITableViewCell {

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ model:Message) {
        nameLabel.text = model.message_create?.message_data?.text
        timeLabel.text = makeFormatedStringFor(timeStamp: Double(model.created_timestamp ?? "0")!)
    }
}
