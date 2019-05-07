//
//  NewsLikesNode.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 28/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewsCommentsNode: ASControlNode {
    let iconNode = ASImageNode()
    let countNode = ASTextNode()
    var commentsCount: Int = 0
    
    init(commentsCount: Int) {
        super.init()
        
        self.commentsCount = commentsCount
        
        iconNode.image = UIImage(named: "comment_outline_24")
        iconNode.style.preferredSize = CGSize(width: 25, height: 25)
        addSubnode(iconNode)
        
        countNode.attributedText = NSAttributedString(string: String(commentsCount), attributes: TextStyles.cellControlStyle)
        addSubnode(countNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 0)
        let iconWithInset = ASInsetLayoutSpec(insets: insets, child: iconNode)
        let mainStack = ASStackLayoutSpec(direction: .horizontal, spacing: 6, justifyContent: .start, alignItems: .center, children: [iconWithInset, countNode])
        mainStack.style.preferredSize = CGSize(width: 70, height: 30)
        
        return mainStack
    }
}
