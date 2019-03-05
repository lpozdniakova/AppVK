//
//  FirebaseLogonViewController.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 04/03/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class FirebaseLogonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func anonymousAuthButton(_ sender: UIButton) {
        let logout = LogonFormController()
        logout.logoutVK()
        Auth.auth().signInAnonymously() { [weak self] (authResult, error) in
            if let error = error {
                self?.show(error)
            } else {
                let user = authResult?.user.uid
                //self!.saveToFirestore(user!)
                FirebaseService.shared.userFirestoreId = user!
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
                self!.present(vc, animated: true)
            }
        }
    }
    
    @IBAction func vkAuthButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Logon", bundle: nil).instantiateInitialViewController() as! LogonFormController
        present(vc, animated: true)
    }

}
