//
//  TextStyles.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 28/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit

struct TextStyles {
    static let cellControlColoredStyle: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 13),
        .foregroundColor: UIColor(red: 254/255, green: 0/255, blue: 41/255, alpha: 1)
    ]
    
//    static let nameStyle: [NSAttributedString.Key: Any] = [
//        .font: UIFont.boldSystemFont(ofSize: 15),
//        .foregroundColor: UIColor.black
//    ]
    
    static let usernameStyle: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 17),
        .foregroundColor: UIColor.vk_color
    ]
    
    static let timeStyle: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.lightGray
    ]
    
    static let postStyle: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 15),
        .foregroundColor: UIColor.black
    ]
    
    static let postLinkStyle: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 15),
        .foregroundColor: UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 1),
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    static let cellControlStyle: [NSAttributedString.Key: Any] = [
        .font : UIFont.systemFont(ofSize: 13),
        .foregroundColor: UIColor.vk_color
    ]
}
