//
//  RealmProvider.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 22/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import RealmSwift


class RealmProvider {
    static func save<T: Object>(items: [T], config: Realm.Configuration = Realm.Configuration.defaultConfiguration, update: Bool = true) {
        print(config.fileURL!)
        
        do {
            let realm = try Realm(configuration: config)
            
            try realm.write {
                realm.add(items, update: update)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
