//
//  NewsHeaderNode.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 27/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewsHeaderNode: ASCellNode {
    //MARK: - Properties
    private let date: Date
    private let source: NewsSource
    private let nameNode = ASTextNode()
    private let dateNode = ASTextNode()
    private let avatarImageNode = ASNetworkImageNode()
    private let imageHeight: CGFloat = 50
    
    init(source: NewsSource, date: Date) {
        self.source = source
        self.date = date
        super.init()
        backgroundColor = .clear
        setupSubnodes()
    }
    
    private func setupSubnodes() {
        nameNode.attributedText = NSAttributedString(string: source.title, attributes: TextStyles.usernameStyle)
        nameNode.backgroundColor = .clear
        addSubnode(nameNode)
        
        dateNode.attributedText = NSAttributedString(string: date.timeAgo(numericDates: false), attributes: TextStyles.timeStyle)
        addSubnode(dateNode)
        
        avatarImageNode.url = source.imageUrl
        avatarImageNode.cornerRadius = imageHeight/2
        avatarImageNode.clipsToBounds = true
        avatarImageNode.shouldRenderProgressImages = true
        avatarImageNode.contentMode = .scaleAspectFill
        addSubnode(avatarImageNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        avatarImageNode.style.preferredSize = CGSize(width: imageHeight, height: imageHeight)
        let insets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 0)
        let avatarWithInset = ASInsetLayoutSpec(insets: insets, child: avatarImageNode)
        
        let nameWithInset = ASInsetLayoutSpec(insets: insets, child: nameNode)
        let dateWithInset = ASInsetLayoutSpec(insets: insets, child: dateNode)
        let verticalStackSpec = ASStackLayoutSpec()
        verticalStackSpec.direction = .vertical
        verticalStackSpec.children = [nameWithInset, dateWithInset]
        
        let horizontalStackSpec = ASStackLayoutSpec()
        horizontalStackSpec.direction = .horizontal
        horizontalStackSpec.children = [avatarWithInset, verticalStackSpec]
        return horizontalStackSpec
    }
}
