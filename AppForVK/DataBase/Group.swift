//
//  Group.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 07/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import SwiftyJSON

class Group {
    
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
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.screen_name = json["screen_name"].stringValue
        self.deactivated = json["deactivated"].stringValue
        self.is_closed = json["is_closed"].intValue
        self.type = json["type"].stringValue
        self.is_admin = json["is_admin"].intValue
        self.is_member = json["is_member"].intValue
        self.is_advertiser = json["is_advertiser"].intValue
        self.photo_50 = json["photo_50"].stringValue
        self.photo_100 = json["photo_100"].stringValue
        self.photo_200 = json["photo_200"].stringValue
    }
}
