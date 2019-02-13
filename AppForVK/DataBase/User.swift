//
//  User.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 07/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: CustomStringConvertible {
    var description: String {
        return "Name is \(first_name)"
    }
    
    //MARK: - Basic fields
    
    let id: Int
    let first_name: String
    let last_name: String
    let deactivated: String
    let is_closed: Int
    let can_access_closed: Int
    let full_name: String
    
    //MARK: - Optional fields
    let nickname: String
    let online: Int
    let photo_50: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.deactivated = json["deactivated"].stringValue
        self.is_closed = json["is_closed"].intValue
        self.can_access_closed = json["can_access_closed"].intValue
        self.full_name = json["last_name"].stringValue + " " + json["first_name"].stringValue
        
        self.nickname = json["nickname"].stringValue
        self.online = json["online"].intValue
        self.photo_50 = json["photo_50"].stringValue
    }
}
