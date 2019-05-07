//
//  NewsFooterNode.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 28/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewsFooterNode: ASCellNode {
    private var likesNode: NewsLikesNode!
    private var commentsNode: NewsCommentsNode!
    private var repostsNode: NewsSharesNode!
    private let viewsIconNode = ASImageNode()
    private var viewsCountNode = ASTextNode()
    
    init(news: NewsItem) {
        super.init()
//        likesNode = NewsLikesNode(likesCount: news.likesCount, liked: news.liked)
        likesNode = NewsLikesNode(news: news)
        addSubnode(likesNode)
        
        commentsNode = NewsCommentsNode(commentsCount: news.commentsCount)
        addSubnode(commentsNode)
        
        repostsNode = NewsSharesNode(repostsCount: news.repostsCount)
        addSubnode(repostsNode)
        
        viewsIconNode.image = UIImage(named: "ic_viewers_24dp_Normal")
        viewsIconNode.style.preferredSize = CGSize(width: 25, height: 25)
        addSubnode(viewsIconNode)
        
        viewsCountNode.attributedText = NSAttributedString(string: String(news.viewsCount), attributes: TextStyles.cellControlStyle)
        addSubnode(viewsCountNode)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        let viewsStack = ASStackLayoutSpec()
        viewsStack.direction = .horizontal
        viewsStack.spacing = 6
        viewsStack.justifyContent = .end
        viewsStack.alignItems = .center
        viewsStack.children = [viewsIconNode, viewsCountNode]
        
        let controlStack = ASStackLayoutSpec()
        controlStack.direction = .horizontal
        controlStack.spacing = 10
        controlStack.justifyContent = .start
        controlStack.alignItems = .center
        controlStack.children = [likesNode, commentsNode, repostsNode]
        controlStack.style.spacingAfter = 3.0
        controlStack.style.spacingBefore = 3.0
        
        let mainStack = ASStackLayoutSpec()
        mainStack.direction = .horizontal
        mainStack.spacing = constrainedSize.max.width - 320
        mainStack.children = [controlStack, viewsStack]
        
        return mainStack
    }
}
