//
//  Groups.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 07/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation

class GroupsResponse: Codable {
    let items: [Group]
}

class Group: Codable {
    
    //MARK: - Basic fields
    let id: Int
    let name: String
    let screen_name: String
    let is_closed: Int
    let deactivated: String
    let type: String
    let is_admin: Int
    let is_member: Int
    let is_advertiser: Int
    let photo_50: String
    let photo_100: String
    let photo_200: String
    
    //MARK: - Optional fields
}
