//
//  HomeViewModel.swift
//  WickedRideDemo
//
//  Created by apple on 6/25/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

class HomeViewModel:NSObject {
    private var chatRooms:ChatRoomsModel!
    
    init(chatroomModel:ChatRoomsModel) {
        self.chatRooms = chatroomModel
    }
    
    func getCountOfTotalChatRooms() -> Int {
        return chatRooms.chatrooms.count
    }
    
    func getModelFor(indexPath:IndexPath) -> ChatRoom? {
        let models = chatRooms.chatrooms.sorted { (chatroom1, chatroom2) -> Bool in
            return (chatroom1.lastMessage.timeStamp ?? "") > (chatroom2.lastMessage.timeStamp ?? "")
        }
        return models[indexPath.row]
    }
    
    func getChatRoom(forIndexPath:IndexPath) -> ChatRoom? {
        return self.chatRooms.chatrooms[forIndexPath.row]
    }
}
