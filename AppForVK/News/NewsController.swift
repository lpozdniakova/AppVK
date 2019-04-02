//
//  NewsController.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 04/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class NewsController: UITableViewController {
    
    private let vkService = VKService()
    private let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    private var news: Results<News>?
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.rowHeight = 500
        //self.tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        pairTableAndRealm()
        
        tableView.register(UINib(nibName: "NewsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: NewsHeaderTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsTextTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTextTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsImageTableViewCell", bundle: nil), forCellReuseIdentifier: NewsImageTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsFooterTableViewCell", bundle: nil), forCellReuseIdentifier: NewsFooterTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsSeparatorTableViewCell", bundle: nil), forCellReuseIdentifier: NewsSeparatorTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "NewsDefaultTableViewCell", bundle: nil), forCellReuseIdentifier: NewsDefaultTableViewCell.reuseIdentifier)
        
        vkService.loadVKNewsFeed() { news, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let news = news {
                RealmProvider.save(items: news)
            }
        }
        
    }
    
    func pairTableAndRealm() {
        //let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        guard let realm = try? Realm() else { return }
        news = realm.objects(News.self)
        
        notificationToken = news?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: 0, section: $0) }), with: .none)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: 0, section: $0) }), with: .none)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: 0, section: $0) }), with: .none)
                tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 54
        case 1:
            if news![indexPath.section].postText == "" {
                return 0
            } else {
                return UITableView.automaticDimension
            }
        case 2:
            return UITableView.automaticDimension
        case 3:
            return 24
        case 4:
            return 5
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderCell") as? NewsHeaderTableViewCell else { return UITableViewCell() }
            let urlUserImage = news![indexPath.section].titlePostPhoto //TODO: - убрать force-unwrap
            cell.userImage.kf.setImage(with: URL(string: urlUserImage))
            cell.userName.text = news![indexPath.section].titlePostLabel //TODO: - убрать force-unwrap
            cell.newsDate.text = Date(timeIntervalSince1970: news![indexPath.section].titlePostTime).timeAgo(numericDates: false) //TODO: - убрать force-unwrap
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell") as? NewsTextTableViewCell else { return UITableViewCell() }
            cell.newsText.text = news![indexPath.section].postText //TODO: - убрать force-unwrap
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell") as? NewsImageTableViewCell else { return UITableViewCell() }
            let imageURL = news![indexPath.section].attachments_typePhoto //TODO: - убрать force-unwrap
            let photoWidth = news?[indexPath.section].attachments_photoWidth ?? 0
            let photoHeight = news?[indexPath.section].attachments_photoHeight ?? 0
            var ratio = 1
            if photoHeight != 0 {
                ratio = photoWidth / photoHeight
            }
            let processor = DownsamplingImageProcessor(size: CGSize(width: tableView.frame.width, height: tableView.frame.width * CGFloat(ratio)))
            cell.newsImage.kf.setImage(with: URL(string: imageURL),
                                       options: [
                                        .processor(processor),
                                        .scaleFactor(UIScreen.main.scale),
                                        .transition(.fade(1)),
                                        .cacheOriginalImage
                ])
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFooterCell") as? NewsFooterTableViewCell else { return UITableViewCell() }
            
            cell.delegateButton = self
            cell.indexPathCell = indexPath
            
            if news![indexPath.section].userLikes == 1 {
                cell.likeButton.setImage(UIImage(named: "Heart"), for: .normal)
                cell.likeLabel.textColor = UIColor(red: 254/255, green: 0/255, blue: 41/255, alpha: 1)
            } else {
                cell.likeButton.setImage(UIImage(named: "HeartWhite"), for: .normal)
                cell.likeLabel.textColor = UIColor.vk_color
            }
            
            cell.likeLabel.text = String(news![indexPath.section].likesCount)
            
            if news![indexPath.section].commentCanPost == 1 {
                cell.commentLabel.text = String(news![indexPath.section].commentsCount)
                cell.iconCommentWidth.constant = 20
                cell.commentLabelWidth.constant = 40
                cell.commentLeadingConstraint.constant = 8
            } else {
                cell.iconCommentWidth.constant = 0
                cell.commentLabelWidth.constant = 0
                cell.commentLeadingConstraint.constant = 0
            }
            
            cell.shareLabel.text = String(news![indexPath.section].repostsCount)
            cell.viewsLabel.text = String(news![indexPath.section].viewsCount)
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSeparatorCell") as? NewsSeparatorTableViewCell else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDefaultCell") as? NewsDefaultTableViewCell else { return UITableViewCell() }
            return cell
        }
    }

    @IBAction func tapRefreshButton(_ sender: Any) {
        vkService.loadVKNewsFeed() { [weak self] news, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let news = news {
                RealmProvider.save(items: news)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension NewsController: CellForButtonsDelegate {
    
    func didTapCompleteButton(indexPath: IndexPath) {
        if news![indexPath.row].userLikes == 0 {
            vkService.addOrDeleteLike(likeType: .post, owner_id: news![indexPath.row].postSource_id, item_id: news![indexPath.row].post_id , action: .addLike)
            do {
                guard let realm = try? Realm(configuration: self.config) else { return }
                realm.beginWrite()
                news![indexPath.row].userLikes = 1
                try realm.commitWrite()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            vkService.addOrDeleteLike(likeType: .post, owner_id: news![indexPath.row].postSource_id, item_id: news![indexPath.row].post_id , action: .deleteLike)
            do {
                guard let realm = try? Realm(configuration: self.config) else { return }
                realm.beginWrite()
                news![indexPath.row].userLikes = 0
                try realm.commitWrite()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
