//
//  HelperFunctions.swift
//  WickedRideDemo
//
//  Created by apple on 6/26/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

func makeFormatedStringFor(timeStamp:Double) -> String {
    let date = Date()
    let secondPress = date.timeIntervalSince1970
    let differenceInSeconds = secondPress - Double(timeStamp)
    let hours = Int(differenceInSeconds / 3600)
    let minutes = (Int(differenceInSeconds) - hours * 3600) / 60
    return hours > 0 ? "\(hours) hrs, \(minutes) mins" : "\(minutes) mins"
}
