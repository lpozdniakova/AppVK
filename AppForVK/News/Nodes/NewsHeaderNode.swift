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
    private let source: Owner
    private let nameNode = ASTextNode()
    private let avatarImageNode = ASNetworkImageNode()
    private let imageHeight: CGFloat = 50
    
    init(source: Owner) {
        self.source = source
        super.init()
        backgroundColor = UIColor.vk_color
        setupSubnodes()
    }
    
    private func setupSubnodes() {
        if source.ownerId > 0 {
            nameNode.attributedText = NSAttributedString(string: source.userName, attributes: [.font : UIFont.systemFont(ofSize: 20)])
        } else {
            nameNode.attributedText = NSAttributedString(string: source.groupName, attributes: [.font : UIFont.systemFont(ofSize: 20)])
        }
        
        nameNode.backgroundColor = .clear
        addSubnode(nameNode)
        
        avatarImageNode.url = URL(fileURLWithPath: source.ownerPhoto)
        avatarImageNode.cornerRadius = imageHeight/2
        avatarImageNode.clipsToBounds = true
        avatarImageNode.shouldRenderProgressImages = true
        avatarImageNode.contentMode = .scaleAspectFill
        addSubnode(avatarImageNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        avatarImageNode.style.preferredSize = CGSize(width: imageHeight, height: imageHeight)
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let avatarWithInset = ASInsetLayoutSpec(insets: insets, child: avatarImageNode)
        
        let textCenterSpec = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: nameNode)
        
        let horizontalStackSpec = ASStackLayoutSpec()
        horizontalStackSpec.direction = .horizontal
        horizontalStackSpec.children = [avatarWithInset, textCenterSpec]
        return horizontalStackSpec
    }
}
