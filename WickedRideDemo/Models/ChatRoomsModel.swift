////
//  ChatRoomsModel.swift
//  WickedRideDemo
//
//  Created by Abhinay on 6/25/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
import TwitterKit
//MARK: -- Model Class

struct ChatRoomsModel:Decodable,Encodable {
    var messages:[Message] = []
    var chatrooms:[ChatRoom] = []
    
    private enum CodingKeys: String, CodingKey {
        case messages = "events"
    }
    
    mutating func updateUserModel(_ userModel:ChatRoomsModel) {
        self = userModel
    }
    
    public init(){
        
    }
    
    /*
     get logged_in_uid
     - loop[ msg in msgs]
        msg_sender_uid
     */
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        messages = try container.decode([Message].self, forKey: .messages)
        for message in messages {
           
            if var chatMessages = chatrooms.filter({$0.chatRoomId == message.chatRoomId}).first?.messages {
                chatMessages.append(message)
//                chatMessages = messages.sorted { (message1, message2) -> Bool in
//                    return message1.created_timestamp ?? "0" <= message2.created_timestamp ?? "0"
//                }
                let indexOfModel = chatrooms.index(where: { $0.chatRoomId == message.chatRoomId })
                
                chatrooms[indexOfModel ?? 0].messages = chatMessages
            }else {
                let chatroomModel = ChatRoom(message: message)
                chatrooms.append(chatroomModel)
            }
        }
    }
}

struct ChatRoom {
    var chatRoomId:String?
    
    var lastMessage: LastMessage = LastMessage()
    var messages:[Message] = []
    var senderUser:LoginUserModel!
    
    public init(message:Message) {
        chatRoomId = message.chatRoomId ?? ""
        lastMessage.textMsg = message.message_create?.message_data?.text ?? ""
        lastMessage.timeStamp = message.created_timestamp ?? ""
        messages.append(message)
    }
    
    mutating func updateUserModel(_ userModel:LoginUserModel) {
        self.senderUser = userModel
    }
    
    func firebaseObjectToInsertForMessages() -> [[String:String]] {
        var messageObjectArray:[[String:String]] = []
        for message in messages {
            let messageObject:[String:String] = ["messageText":message.message_create?.message_data?.text ?? "","messageId":message.messageId ?? "","timestamp":message.created_timestamp ?? ""]
            messageObjectArray.append(messageObject)
        }
        
        return messageObjectArray
    }
    
}

struct LastMessage {
    var timeStamp:String? {
        didSet {
            timeStampToDisplay = makeFormatedStringFor(timeStamp:Double(timeStamp ?? "0") ?? 0.0)
        }
    }
    var textMsg:String?
    var timeStampToDisplay:String?
    
    func firebaseObjectToInsert() -> [String:String] {
        return ["timeStamp" : timeStamp ?? "", "textMsg":textMsg ?? "", "timeStampToDisplay":timeStamp ?? ""]
    }
}

struct Message:Decodable,Encodable {
    let created_timestamp:String?
    let messageId: String?
    let message_create:MessageBody?
    let chatRoomId:String?
    
    private enum CodingKeys: String, CodingKey {
        case created_timestamp
        case messageId = "id"
        case message_create
    }
    
    public init(from decoder: Decoder) throws {
        let currentUserId = NetworkHandler.networkHandler.userModel?.userId
        let container = try decoder.container(keyedBy: CodingKeys.self)
        messageId = try container.decode(String.self, forKey: .messageId)
        created_timestamp = try container.decode(String.self, forKey: .created_timestamp)
        message_create = try container.decode(MessageBody.self, forKey: .message_create)
        chatRoomId = "ChatRoom-\(currentUserId ?? "")-\((currentUserId != message_create?.sender_id ? message_create?.sender_id : message_create?.receivers?.recipient_id) ?? "")"
    }
    
    public init() {
        self.init()
    }
}

//MARK: Main Message Body Sender , Receiver , Message Detail
struct MessageBody:Decodable,Encodable {
   let message_data:MessageData?
   let sender_id:String?
   let receivers: Receivers?
    
    private enum CodingKeys:String, CodingKey {
        case message_data
        case sender_id
        case receivers = "target"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message_data = try container.decode(MessageData.self, forKey: .message_data)
        sender_id = try container.decode(String.self, forKey: .sender_id)
        receivers = try container.decode(Receivers.self, forKey: .receivers)
    }
}

struct Receivers:Decodable,Encodable {
    let recipient_id:String?
    var recipient:LoginUserModel?
    
    private enum CodingKeys:String, CodingKey {
        case recipient_id
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        recipient_id = try container.decode(String.self,forKey: .recipient_id)
    }
}

struct MessageData:Decodable,Encodable {
    let entities:Entity?
    let text:String?
}

struct Entity:Decodable,Encodable {
    let hashtags:[String]?
    let symbols:[String]?
    let urls:[String]?
    let user_mentions:[String]?
}
