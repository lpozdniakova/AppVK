//
//  Friends.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 26/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation

struct Friends {
    let name: String
    let avatarPath: String
    
    init (name: String, avatarPath: String) {
        self.name = name
        self.avatarPath = avatarPath
    }
}

var friend1 = Friends(name: "Александр Федоров", avatarPath: "Александр Федоров.jpg")
var friend2 = Friends(name: "Anna Ershova", avatarPath: "Anna Ershova.png")
var friend3 = Friends(name: "Evhenii Kovalenko", avatarPath: "Evhenii Kovalenko.jpg")
var friend4 = Friends(name: "Nikolay Trofimov", avatarPath: "Nikolay Trofimov.jpg")
var friend5 = Friends(name: "Vladimir Bozhenov", avatarPath: "Vladimir Bozhenov.png")
var friend6 = Friends(name: "Анастасия Уженцева", avatarPath: "Анастасия Уженцева.jpg")
var friend7 = Friends(name: "Керим Ильясов", avatarPath: "Керим Ильясов.jpg")
var friend8 = Friends(name: "Максим Носов", avatarPath: "Максим Носов.jpg")
var friend9 = Friends(name: "Алексей Канатьев", avatarPath: "Алексей Канатьев.jpg")
var friend10 = Friends(name: "Алексей Машков", avatarPath: "Алексей Машков.jpg")
var friend11 = Friends(name: "Андрей Антропов", avatarPath: "Андрей Антропов.jpg")
var friend12 = Friends(name: "Артем Еровиков", avatarPath: "Артем Еровиков.jpeg")
var friend13 = Friends(name: "Артем Чурсин", avatarPath: "Артем Чурсин.jpg")
var friend14 = Friends(name: "Виктор Новосёлов", avatarPath: "Виктор Новосёлов.jpg")
var friend15 = Friends(name: "Геннадий Степанов", avatarPath: "Геннадий Степанов.png")
var friend16 = Friends(name: "Дмитрий Федоринов", avatarPath: "Дмитрий Федоринов.jpg")

var friendsDataBase = [
    friend1,
    friend2,
    friend3,
    friend4,
    friend5,
    friend6,
    friend7,
    friend8,
    friend9,
    friend10,
    friend11,
    friend12,
    friend13,
    friend14,
    friend15,
    friend16
    ]

var friendImagesDataBase = ["Александр Федоров": [
    "001.jpg",
    "002.jpg",
    "003.png",
    "004.jpg"
]]

func getFriendImages(friendName: String) -> [String] {
    return friendImagesDataBase[friendName] ?? []
}
