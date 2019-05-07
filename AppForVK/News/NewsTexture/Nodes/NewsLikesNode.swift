//
//  NewsLikesNode.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 28/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewsLikesNode: ASControlNode {
    private let vkService = VKService()
    private let iconNode = ASImageNode()
    private let countNode = ASTextNode()
    private var likesCount: Int = 0
    private var liked: Bool = false
    private var news: NewsItem!
    
//    init(likesCount: Int, liked: Bool) {
    init(news: NewsItem) {
        super.init()
        
        self.news = news
        self.likesCount = news.likesCount
        self.liked = news.liked
        
        iconNode.image = UIImage(named: liked ? "Heart" : "HeartWhite")
        iconNode.style.preferredSize = CGSize(width: 25, height: 25)
        addSubnode(iconNode)
        
        let attributes = liked ? TextStyles.cellControlColoredStyle : TextStyles.cellControlStyle
        countNode.attributedText = NSAttributedString(string: String(likesCount), attributes: attributes)
        addSubnode(countNode)
        
        self.addTarget(self, action: #selector(tapLike(_:)), forControlEvents: .touchUpInside)
    
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 0)
        let iconWithInset = ASInsetLayoutSpec(insets: insets, child: iconNode)
        let mainStack = ASStackLayoutSpec(direction: .horizontal, spacing: 6, justifyContent: .start, alignItems: .center, children: [iconWithInset, countNode])
        mainStack.style.preferredSize = CGSize(width: 70, height: 30)
        
        return mainStack
    }
    
    @objc func tapLike(_ sender: ASControlNode) {
        if liked {
            vkService.addOrDeleteLike(likeType: .post, owner_id: news.sourceID, item_id: news.id , action: .deleteLike)
            liked = false
            iconNode.image = UIImage(named: liked ? "Heart" : "HeartWhite")
            let attributes = liked ? TextStyles.cellControlColoredStyle : TextStyles.cellControlStyle
            countNode.attributedText = NSAttributedString(string: String(likesCount), attributes: attributes)
        } else {
            vkService.addOrDeleteLike(likeType: .post, owner_id: news.sourceID, item_id: news.id , action: .addLike)
            liked = true
            iconNode.image = UIImage(named: liked ? "Heart" : "HeartWhite")
            let attributes = liked ? TextStyles.cellControlColoredStyle : TextStyles.cellControlStyle
            countNode.attributedText = NSAttributedString(string: String(likesCount), attributes: attributes)
        }
    }
    
}
