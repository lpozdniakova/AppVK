//
//  Photo.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 12/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
    
    //MARK: - Basic fields
    @objc dynamic var owner_id: Int = 0
    @objc dynamic var extended: Int = 0
    @objc dynamic var offset: Int = 0
    @objc dynamic var count: Int = 0
    @objc dynamic var photo_sizes: Int = 0
    @objc dynamic var no_service_albums: Int = 0
    @objc dynamic var need_hidden: Int = 0
    @objc dynamic var skip_hidden: Int = 0
    @objc dynamic var url: String = ""
    
     convenience init(json: JSON) {
        self.init()
        self.owner_id = json["owner_id"].intValue
        self.extended = json["extended"].intValue
        self.offset = json["offset"].intValue
        self.count = json["count"].intValue
        self.photo_sizes = json["photo_sizes"].intValue
        self.no_service_albums = json["no_service_albums"].intValue
        self.need_hidden = json["need_hidden"].intValue
        self.skip_hidden = json["skip_hidden"].intValue
        self.url = json["sizes"][4]["url"].stringValue
    }
}
