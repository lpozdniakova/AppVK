//
//  Photo.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 12/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo {
    
    //MARK: - Basic fields
    let owner_id: Int
    let extended: Int
    let offset: Int
    let count: Int
    let photo_sizes: Int
    let no_service_albums: Int
    let need_hidden: Int
    let skip_hidden: Int
    let url: String
    
    init(json: JSON) {
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
