//
//  ChatDetailViewModel.swift
//  WickedRideDemo
//
//  Created by apple on 6/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ChatDetailViewModel: NSObject {
   private var chatRoom:ChatRoom?
    
   init(chatroom:ChatRoom) {
        self.chatRoom = chatroom
   }
    
    func getTotalCount() -> Int {
        return chatRoom?.messages.count ?? 0
    }
    
    func getModelFor(indexPath:IndexPath) -> Message? {
        return chatRoom?.messages[indexPath.row]
    }
    
    func cellType(forIndexPath:IndexPath) -> Bool {
        return self.chatRoom?.messages[forIndexPath.row].message_create?.sender_id == NetworkHandler.networkHandler.userModel.userId
    }
    
    func getName() -> String? {
        return chatRoom?.senderUser.userName
    }
    
    func getTwitterHandle() -> String {
        return "@" + (chatRoom?.senderUser?.screenName ?? "")
    }
}
