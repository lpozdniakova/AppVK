//
//  Users.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 07/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation

class UsersResponse: Codable {
    let items: [User]
}

class User: Codable {
    
    //MARK: - Basic fields
    
    let id: Int
    let first_name: String
    let last_name: String
    let deactivated: String
    let is_closed: Int
    let can_access_closed: Int
    
    //MARK: - Optional fields
    let nickname: String
    let online: Int
    let photo_id: String    
}
