//
//  FirebaseService.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 05/03/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    private init() { }
    
    public static let shared = FirebaseService()
    
    var userFirestoreId: String = ""
}
