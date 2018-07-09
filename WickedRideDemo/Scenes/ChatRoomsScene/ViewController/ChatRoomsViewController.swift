//
//  HomeViewController.swift
//  WickedRideDemo
//
//  Created by Abhinay on 6/25/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ChatRoomsViewController: UIViewController {
    
    var homeViewModel:HomeViewModel?
    
    @IBOutlet weak var chatListingTableView: UITableView!
    let ChatRoomCellIdentifier = "ChatRoomDisplayTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ChatRoomListingScreen"
        chatListingTableView.register(UINib(nibName: "ChatRoomDisplayTableViewCell", bundle: nil), forCellReuseIdentifier: ChatRoomCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chatListingTableView.reloadData()
    }
}

extension ChatRoomsViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.homeViewModel?.getCountOfTotalChatRooms()) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let chatroomCell = tableView.dequeueReusableCell(withIdentifier: ChatRoomCellIdentifier) as? ChatRoomDisplayTableViewCell {
            if let chatDataModel = self.homeViewModel?.getModelFor(indexPath:indexPath) {
                chatroomCell.updateData(chatDataModel)
            }
            return chatroomCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppRouter.sharedInstance.loadChatDetailViewController(withData:(homeViewModel?.getModelFor(indexPath: indexPath))!)
        
    }
    
}
