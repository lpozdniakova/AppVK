//
//  News.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 24/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation

struct News {
    let newsId: String
    let newsText: String
    let picturesArray: [String]?
    let likesCount: Int
    let commentsCount: Int
    let sharesCount: Int
    let viewsCount: Int
    
    init (newsId: String, newsText: String, picturesArray: [String], likesCount: Int, commentsCount: Int, sharesCount: Int, viewsCount: Int) {
        self.newsId = newsId
        self.newsText = newsText
        self.picturesArray = picturesArray
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.sharesCount = sharesCount
        self.viewsCount = viewsCount
    }
}

var news1 = News(
    newsId: "1",
    newsText: "В первой части мы рассматривали рейтинги, агентства и зарплаты в сфере digital, сегодня поговорим о направлениях развития. За основу взяли исследование Accenture Technology Vision, отчет агентства Fjord, тренды от GlobalWebIndex и видение портала о digital-маркетинге Think with Google.",
    picturesArray: ["iconIOS.png", "iconJava.png", "iconJava.png", "iconWEB.png", "iconPython.png", "iconAndroid.png", "iconGameDev.png"], likesCount: 789, commentsCount: 321, sharesCount: 57, viewsCount: 1234)

var news2 = News(
    newsId: "2",
    newsText: "В первой части мы рассматривали рейтинги, агентства и зарплаты в сфере digital, сегодня поговорим о направлениях развития. За основу взяли исследование Accenture Technology Vision, отчет агентства Fjord, тренды от GlobalWebIndex и видение портала о digital-маркетинге Think with Google.",
    picturesArray: ["iconIOS.png", "iconJava.png"], likesCount: 259, commentsCount: 124, sharesCount: 45, viewsCount: 865)

var news3 = News(
    newsId: "3",
    newsText: "Это перевод статьи Ланса Ына (Lance Ng) What Microsoft and Google Are Not Telling You About Their AI. Автор предлагает критически посмотреть на возможности ИИ-систем и оценить разницу между декларируемыми и реальными на сегодня возможностями искусственного интеллекта.",
    picturesArray: ["iconIOS.png", "iconJava.png", "iconAndroid.png"], likesCount: 280, commentsCount: 120, sharesCount: 19, viewsCount: 2019)

var news4 = News(
    newsId: "4",
    newsText: "Это перевод статьи Ланса Ына (Lance Ng) What Microsoft and Google Are Not Telling You About Their AI. Автор предлагает критически посмотреть на возможности ИИ-систем и оценить разницу между декларируемыми и реальными на сегодня возможностями искусственного интеллекта.",
    picturesArray: ["iconIOS.png", "iconJava.png", "iconAndroid.png", "iconGameDev.png"], likesCount: 999, commentsCount: 999, sharesCount: 999, viewsCount: 2019)
