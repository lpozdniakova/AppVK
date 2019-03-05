//
//  MainViewController.swift
//  AppForVK
//
//  Created by Семериков Михаил on 19.12.2018.
//  Copyright © 2018 Семериков Михаил. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.vk_color
        saveToFirestore(FirebaseService.shared.userFirestoreId)
    }
    
    //MARK: - Firestore
    
    let database = Firestore.firestore()
    
    func saveToFirestore(_ user: String = "vk") {
        database.collection("anonymousUsers")
        .document(user)
        .setData(["Last seen":Date()], merge: true) { error in
            if let error = error {
                self.show(error)
            }
        }
    }
}
