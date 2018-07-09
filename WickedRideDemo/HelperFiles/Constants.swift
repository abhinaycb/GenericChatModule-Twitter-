//
//  Constants.swift
//  WickedRideDemo
//
//  Created by apple on 6/16/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation
struct Constants {
    static let consumerKey:String = "m5JOWZUyldPwb3C2pjvUsWkUi"
    static let consumerSecret:String = "AOWgVloPeNhgaDN4eqlHDTmMkDtBdMGrcxMhD3sFIAs83iGQ0H"
}

struct ApiEndPoints {
    static let followersEndPointUrl = "https://api.twitter.com/1.1/direct_messages/events/list.json"
    static let twitterAppUrl = "https://itunes.apple.com/in/app/twitter/id333903271?mt=8"
}

typealias loginHandler = () -> ()
