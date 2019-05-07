//
//  NewsTextureController.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 27/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewsTextureController: ASViewController<ASDisplayNode> {
    
    // Properties
    var tableNode: ASTableNode {
        return node as! ASTableNode
    }
    let vkService = VKService()
    var totalNews = [NewsItem]()
    var nextFrom: String
    var lastRefreshed: Date?
    var refreshControl: UIRefreshControl = {
        let rC = UIRefreshControl()
        rC.attributedTitle = NSAttributedString(string: "Fetching news...")
        rC.tintColor = .red
        return rC
    }()
    
    init(news: [NewsItem] = [], nextFrom: String = "") {
        self.totalNews = news
        self.nextFrom = nextFrom
        
        super.init(node: ASTableNode())
        self.tableNode.delegate = self
        self.tableNode.dataSource = self
        self.tableNode.allowsSelection = false
        self.tableNode.view.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableNode.view.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc private func refreshNews() {
        vkService.loadNews(upTo: lastRefreshed) { [weak self] result, _ in
            guard let self = self else { return }
            
            self.lastRefreshed = Date()
            switch result {
            case .success(let news):
                self.totalNews = news + self.totalNews
                self.refreshControl.endRefreshing()
                self.tableNode.reloadData()
                
            case .failure(let error):
                self.show(error)
            }
        }
    }
}

extension NewsTextureController: ASTableDelegate, ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return totalNews.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
//        let newsItem = totalNews[section]
//        var rowsCount = 2
//        if newsItem.text != "" { rowsCount += 1 }
//        if !newsItem.photos.isEmpty { rowsCount += 1 }
//        if newsItem.gif != nil { rowsCount += 1 }
//        return rowsCount
        return 5
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard totalNews.count > indexPath.section,
            let source = totalNews[indexPath.section].source else { return { ASCellNode() } }
        let news = totalNews[indexPath.section]
        let date = totalNews[indexPath.section].date
        let text = totalNews[indexPath.section].text
        
        switch indexPath.row {
        case 0:
            let cellNodeBlock = { () -> ASCellNode in
                let node = NewsHeaderNode(source: source, date: date)
                return node
            }
            
            return cellNodeBlock
        case 1:
            let cellNodeBlock = { () -> ASCellNode in
                let node = NewsTextNode(text: text)
                return node
            }
            
            return cellNodeBlock
        case 2:
            if let photo = totalNews[indexPath.section].photos.first {
                let cellNodeBlock = { () -> ASCellNode in
                    let node = NewsImageNode(resource: photo)
                    return node
                }
                
                return cellNodeBlock
            } else if let gif = totalNews[indexPath.section].gif {
                let cellNodeBlock = { () -> ASCellNode in
                    let node = NewsImageNode(resource: gif)
                    return node
                }
                
                return cellNodeBlock
            } 
            
            return { ASCellNode() }
        case 3:
            let cellNodeBlock = { () -> ASCellNode in
                let node = NewsFooterNode(news: news)
                return node
            }
            
            return cellNodeBlock
        case 4:
            let cellNodeBlock = { () -> ASCellNode in
                let node = NewsSeparatorNode()
                return node
            }
            
            return cellNodeBlock
        default:
            return { ASCellNode() }
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        vkService.loadNews(startFrom: nextFrom) { [weak self] result, nextFrom in
            guard let self = self else { return }
            
            self.nextFrom = nextFrom
            
            switch result {
            case .success(let news):
                self.insertNews(news)
                context.completeBatchFetching(true)
            case .failure(let error):
                self.show(error)
                context.completeBatchFetching(false)
            }
        }
    }
    
    func insertNews(_ news: [NewsItem]) {
        
        var indexSet = IndexSet()
        let newNumberOfSections = totalNews.count + news.count
        for section in totalNews.count ..< newNumberOfSections {
            indexSet.insert(section)
        }
        
        totalNews.append(contentsOf: news)
        tableNode.insertSections(indexSet, with: .automatic)
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
}
