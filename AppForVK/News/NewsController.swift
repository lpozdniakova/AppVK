//
//  NewsController.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 04/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit

class NewsController: UITableViewController {
    
    var arrayNews: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        tableView.register(UINib(nibName: "News2ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "News2ImageCell")
        tableView.register(UINib(nibName: "News3ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "News3ImageCell")
        tableView.register(UINib(nibName: "News4ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "News4ImageCell")
        arrayNews = [news1, news2, news3, news4]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var newsCell = UITableViewCell()
        let news = arrayNews[indexPath.row]
        if let picturesCount = arrayNews[indexPath.row].picturesArray?.count {
            if (picturesCount == 2) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "News2ImageCell", for: indexPath) as! News2ImageTableViewCell
                setNewsAttributes2Image(news: news, cellToDisplay: cell, indexPath: indexPath)
                newsCell = cell
            } else if (picturesCount == 3) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "News3ImageCell", for: indexPath) as! News3ImageTableViewCell
                setNewsAttributes3Image(news: news, cellToDisplay: cell, indexPath: indexPath)
                newsCell = cell
            } else if (picturesCount == 4) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "News4ImageCell", for: indexPath) as! News4ImageTableViewCell
                setNewsAttributes4Image(news: news, cellToDisplay: cell, indexPath: indexPath)
                newsCell = cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
                setNewsAttributes(news: news, cellToDisplay: cell, indexPath: indexPath)
                newsCell = cell
            }
        }
        return newsCell
    }
        
    func setNewsAttributes(news: News, cellToDisplay: NewsTableViewCell, indexPath: IndexPath) {
        cellToDisplay.newsText.text = arrayNews[indexPath.row].newsText
        cellToDisplay.arrayNewsImage = arrayNews[indexPath.row].picturesArray ?? []
        cellToDisplay.tapLike.updateCount(likes: arrayNews[indexPath.row].likesCount)
        cellToDisplay.tapShare.updateCount(share: arrayNews[indexPath.row].sharesCount)
        cellToDisplay.tapComment.updateCount(comment: arrayNews[indexPath.row].commentsCount)
        cellToDisplay.tapCount.updateCount(views: arrayNews[indexPath.row].viewsCount)
    }
    
    func setNewsAttributes2Image(news: News, cellToDisplay: News2ImageTableViewCell, indexPath: IndexPath) {
        cellToDisplay.newsText.text = arrayNews[indexPath.row].newsText
        cellToDisplay.newsTopImage.image = UIImage(named: arrayNews[indexPath.row].picturesArray![0])
        cellToDisplay.newsBottomImage.image = UIImage(named: arrayNews[indexPath.row].picturesArray![1])
        cellToDisplay.tapLike.updateCount(likes: arrayNews[indexPath.row].likesCount)
        cellToDisplay.tapShare.updateCount(share: arrayNews[indexPath.row].sharesCount)
        cellToDisplay.tapComment.updateCount(comment: arrayNews[indexPath.row].commentsCount)
        cellToDisplay.tapCount.updateCount(views: arrayNews[indexPath.row].viewsCount)
    }
    
    func setNewsAttributes3Image(news: News, cellToDisplay: News3ImageTableViewCell, indexPath: IndexPath) {
        cellToDisplay.newsText.text = arrayNews[indexPath.row].newsText
        cellToDisplay.newsTopLeftImage.image = UIImage(named: arrayNews[indexPath.row].picturesArray![0])
        cellToDisplay.newsTopRightImage.image = UIImage(named: arrayNews[indexPath.row].picturesArray![1])
        cellToDisplay.newsBottomImage.image = UIImage(named: arrayNews[indexPath.row].picturesArray![2])
        cellToDisplay.tapLike.updateCount(likes: arrayNews[indexPath.row].likesCount)
        cellToDisplay.tapShare.updateCount(share: arrayNews[indexPath.row].sharesCount)
        cellToDisplay.tapComment.updateCount(comment: arrayNews[indexPath.row].commentsCount)
        cellToDisplay.tapCount.updateCount(views: arrayNews[indexPath.row].viewsCount)
    }
    
    func setNewsAttributes4Image(news: News, cellToDisplay: News4ImageTableViewCell, indexPath: IndexPath) {
        cellToDisplay.newsText.text = arrayNews[indexPath.row].newsText
        cellToDisplay.newsTopLeftImage.image = UIImage(named: arrayNews[indexPath.row].picturesArray![0])
        cellToDisplay.newsTopRightImage.image = UIImage(named: arrayNews[indexPath.row].picturesArray![1])
        cellToDisplay.newsBottomLeftImage.image = UIImage(named: arrayNews[indexPath.row].picturesArray![2])
        cellToDisplay.newsBottomRightImage.image = UIImage(named: arrayNews[indexPath.row].picturesArray![3])
        cellToDisplay.tapLike.updateCount(likes: arrayNews[indexPath.row].likesCount)
        cellToDisplay.tapShare.updateCount(share: arrayNews[indexPath.row].sharesCount)
        cellToDisplay.tapComment.updateCount(comment: arrayNews[indexPath.row].commentsCount)
        cellToDisplay.tapCount.updateCount(views: arrayNews[indexPath.row].viewsCount)
    }

}
