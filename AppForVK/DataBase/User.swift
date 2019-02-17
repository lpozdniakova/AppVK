//
//  User.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 07/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object {
    
    //MARK: - Basic fields
    
    @objc dynamic var id: Int = 0
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var deactivated: String = ""
    @objc dynamic var is_closed: Int = 0
    @objc dynamic var can_access_closed: Int = 0
    @objc dynamic var full_name: String = ""
    
    //MARK: - Optional fields
    @objc dynamic var nickname: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var photo_50: String = ""
    
    convenience init(json: JSON) {
        self.init()
        
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
