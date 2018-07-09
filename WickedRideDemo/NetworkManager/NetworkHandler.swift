//
//  NetworkHandler.swift
//  WickedRideDemo
//
//  Created by apple on 6/16/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import FirebaseAuth
import TwitterKit
import FirebaseDatabase

class NetworkHandler: NSObject {
    
    static let networkHandler = NetworkHandler()
    var chatroomDetails:ChatRoomsModel!
    let ref = Database.database().reference()
    var client:TWTRAPIClient!
    var userModel:LoginUserModel! {
        didSet {
            client = TWTRAPIClient.init(userID: userModel?.userId)
            self.fetchUserDetails(userId: userModel.userId ?? "") { [weak self](user, error) in
                if error != nil {
                    print("MARK: I have some error to fix me asap")
                }else {
                    self?.userModel.screenName = user?.screenName ?? ""
                    self?.userModel.profileImageMiniURL = user?.profileImageMiniURL ?? ""
                    self?.userModel.profileImageURL = user?.profileImageURL ?? ""
                }
            }
        }
    }
    
    func initiateTwitterSession() {
        TWTRTwitter.sharedInstance().start(withConsumerKey:Constants.consumerKey, consumerSecret:Constants.consumerSecret)
    }
    
    func fetchInitialMessages(_ completion:@escaping (ChatRoomsModel?) -> ()) {
        let endPointUrl = ApiEndPoints.followersEndPointUrl
        var error:NSError?
        let twitterRequest = client.urlRequest(withMethod: "GET", urlString: endPointUrl, parameters: ["user_id":userModel?.userId ?? ""], error: &error)
        
        client.sendTwitterRequest(twitterRequest) { [weak self](response, data, error) in
            if error != nil {
                print(error!)
                return
            } else {
                do {
                    let decoder = JSONDecoder()
                    self?.chatroomDetails = try decoder.decode(ChatRoomsModel.self, from: data!)
                    print("MARK: MessagesFetchedSuccessfully")
                    self?.updateUserDetailsInModels(completion,chatRoomModel: (self?.chatroomDetails)!)
                } catch {
                    print(error)
                    return
                }
            }
        }
    }
    
    func updateUserDetailsInModels(_ completion:@escaping (ChatRoomsModel?) -> (),chatRoomModel:ChatRoomsModel) {
        var modelToSend:ChatRoomsModel? = ChatRoomsModel()
        var index = 0
        for chatRoom in chatRoomModel.chatrooms {
            var modelToUpdate = chatRoomModel.chatrooms.filter{$0.chatRoomId ==  chatRoom.chatRoomId}.first!
            let chatRoomReciptentId = chatRoom.chatRoomId?.split(separator: "-").last
            
            fetchUserDetails(userId: String(chatRoomReciptentId ?? ""), { [weak self] user,error in
                if error != nil || user == nil {
                    print("MARK: I have some error to fix me asap")
                    index += 1
                    completion(nil)
                }
                
                modelToUpdate.senderUser = LoginUserModel(userModel: user!)
                modelToSend?.chatrooms.append(modelToUpdate)
                
                if chatRoomModel.chatrooms.last?.chatRoomId?.contains(chatRoomReciptentId ?? "") ?? false && index == chatRoomModel.chatrooms.count - 1 {
                    print("MARK: AddUserInFirebaseFinallyWhenItHasRetrivedAllUserRelatedDetailsOfChatRoomSender")
                    self?.addUserDataInFirebase(withData:modelToSend)
                    completion(modelToSend)
                }
                index += 1
            })
        }
    }
    
    func addUserDataInFirebase(withData:ChatRoomsModel?) {
        //add chatroom node in chats node
        
        for chatroom in withData?.chatrooms ?? [] {
            let chatroomId = chatroom.messages.first?.messageId
            let chatNodeToBeInserted:Dictionary<String,Any> = [ chatroomId! : [ "lastMessage":chatroom.lastMessage.firebaseObjectToInsert(),"senderUser":chatroom.senderUser.firebaseObjectToInsert()]]

            //add messages nodes all message
            let messageNodeToBeInserted:[String:Any] = [chatroomId!:chatroom.firebaseObjectToInsertForMessages()]
            
            ref.child("chats").child(chatroomId ?? "").setValue(chatNodeToBeInserted)
            ref.child("messages").child(chatroomId ?? "").setValue(messageNodeToBeInserted)
            print("MARK: chat that iam saving -: \(chatNodeToBeInserted)")
            print("MARK: message node to be inserted -: \(messageNodeToBeInserted)")
        }
        //add user node in users
    }
    
    func fetchUserDetails(userId:String,_ completion:@escaping(TWTRUser?,Error?)->()) {
        
        client.loadUser(withID: userId) { (user, error) in
            if error != nil {
                //TODO: Show Error Message
                print("MARK: I have some error to fix me asap -: \(error.debugDescription) + \(error?.localizedDescription)")
                return
            }
            completion(user,nil)
        }
    }
}
//Code To Check JSON Structure
//let jsonSerialized = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
//print(jsonSerialized)
//
