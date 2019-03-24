//
//  News.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 24/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class News: Object {
    @objc dynamic var newsType = ""
    @objc dynamic var titlePostId = 0
    @objc dynamic var titlePostPhoto = ""
    @objc dynamic var titlePostLabel = ""
    @objc dynamic var titlePostTime: Double = 0.0
    @objc dynamic var geoCoordinates = ""
    @objc dynamic var geoPlaceTitle = ""
    
    @objc dynamic var postSource_id = 0
    @objc dynamic var postText = ""
    @objc dynamic var attachments_typePhoto: String = ""
    @objc dynamic var attachments_photoSize = ""
    @objc dynamic var post_id = 0
    
    @objc dynamic var postImage = ""
    
    @objc dynamic var commentsCount = 0
    @objc dynamic var likesCount = 0
    @objc dynamic var commentCanPost = 0
    
    @objc dynamic var userLikes = 0
    @objc dynamic var repostsCount = 0
    @objc dynamic var viewsCount = 0
    
    override static func primaryKey() -> String? {
        return "titlePostId"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.newsType = json["type"].stringValue
        self.postSource_id = json["source_id"].intValue
        self.postText = json["text"].stringValue
        self.titlePostTime = json["date"].doubleValue
        
        self.attachments_typePhoto = json["attachments"][0]["photo"]["photo_604"].stringValue
        if !json["attachments"][0]["width"].stringValue.isEmpty {
            attachments_photoSize = json["attachments"][0]["photo"]["width"].stringValue + "x" + json["attachments"][0]["photo"]["height"].stringValue
        }
        
        self.postImage = json["photos"][0]["src"].stringValue
        
        self.post_id = json["post_id"].intValue
        self.geoCoordinates = json["geo"]["coordinates"].stringValue
        self.geoPlaceTitle = json["geo"]["place"]["title"].stringValue
        
        self.commentsCount = json["comments"]["count"].intValue
        self.likesCount = json["likes"]["count"].intValue
        self.commentCanPost = json["comments"]["can_post"].intValue
        self.userLikes = json["likes"]["user_likes"].intValue
        self.repostsCount = json["reposts"]["count"].intValue
        self.viewsCount = json["views"]["count"].intValue
    }
    
}
