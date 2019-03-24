//
//  NewsController.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 04/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit
import RealmSwift

class NewsController: UITableViewController {
    
    private let vkService = VKService()
    private let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    private var news: Results<News>?
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 250
        pairTableAndRealm()
        
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
        guard let realm = try? Realm() else { return }
        news = realm.objects(News.self)
        
        notificationToken = news?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .none)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .none)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .none)
                tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = "newsPostTableViewCell"
        if news![indexPath.row].newsType == "post" {
            identifier = "newsPostTableViewCell"
        } else {
            identifier = "NewsPhotoCell"
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? NewsPostTableViewCell else { return UITableViewCell() }
        cell.configure(with: news![indexPath.row]) //TODO: - Убрать force-unwrap
        cell.delegateButton = self
        cell.indexPathCell = indexPath
        return cell
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
