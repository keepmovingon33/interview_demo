//
//  Post.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import Foundation

struct Car: Equatable {
    let status: String?
    let photo: String
    let title: String
    let subTitle: String
    let badge: String
    let accidentStatus: String
    let personalUse: Bool
    let ownerNumberText: String
    let serviceHistoryText: String
    let dealerPhone: String
}

struct CarList: Equatable {
    let listings: [Car]
}
