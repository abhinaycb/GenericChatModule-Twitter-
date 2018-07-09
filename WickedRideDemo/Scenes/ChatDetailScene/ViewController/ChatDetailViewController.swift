//
//  ChatDetailViewController.swift
//  WickedRideDemo
//
//  Created by apple on 6/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ChatDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var profilePhotoIImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    @IBOutlet weak var chatDetailTableView: UITableView!
    
    var viewModel:ChatDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatDetailTableView.delegate = self
        chatDetailTableView.dataSource = self
        chatDetailTableView.register(UINib(nibName: "ChatDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatDetailTableViewCell")
         chatDetailTableView.register(UINib(nibName: "ChatDetailRightTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatDetailRightTableViewCell")
        configureUserDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chatDetailTableView.reloadData()
    }
    
    func configureUserDetails() {
        nameLabel.text = viewModel.getName()
        twitterHandleLabel.text = viewModel.getTwitterHandle()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        AppRouter.sharedInstance.popToChatRoomsViewController()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTotalCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.cellType(forIndexPath:indexPath) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatDetailTableViewCell", for: indexPath) as? ChatDetailTableViewCell {
                cell.configure(viewModel.getModelFor(indexPath:indexPath) ?? Message())
                return cell
            }
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatDetailRightTableViewCell", for: indexPath) as? ChatDetailRightTableViewCell {
            cell.configure(viewModel.getModelFor(indexPath:indexPath) ?? Message())
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
