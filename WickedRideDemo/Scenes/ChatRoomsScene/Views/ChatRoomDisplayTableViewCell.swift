//
//  ChatRoomDisplayTableViewCell.swift
//  WickedRideDemo
//
//  Created by Abhinay on 6/25/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
//MARK: TableViewCell
class ChatRoomDisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Update data of chatroom cell ui components
    func updateData(_ chatroom:ChatRoom) {
        self.nameLabel.text = chatroom.senderUser?.userName ?? ""
        self.twitterHandleLabel.text = "@" + (chatroom.senderUser?.screenName)! 
        self.lastMessageLabel.text = chatroom.messages[0].message_create?.message_data?.text ?? ""
        self.timeLabel.text =  makeFormatedStringFor(timeStamp: Double(chatroom.lastMessage.timeStamp ?? "0")!)
    }
}
