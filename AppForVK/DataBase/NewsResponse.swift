//
//  NewsResponse.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 06/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class NewsResponse: Object {
    @objc dynamic var previousPageStartsFrom = ""
    @objc dynamic var nextPageStartsFrom = ""
    var news = List<News>()
    
    convenience init(json: JSON) {
        self.init()
        self.nextPageStartsFrom = json["next_from"].stringValue
        
    }
    
    override static func primaryKey() -> String {
        return "nextPageStartsFrom"
    }
}
