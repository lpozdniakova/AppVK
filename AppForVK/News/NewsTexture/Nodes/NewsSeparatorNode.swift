//
//  NewsSeparatorNode.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 28/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewsSeparatorNode: ASCellNode {

    private let node = ASDisplayNode()
    
    override init() {
        super.init()
        backgroundColor = UIColor.lightGray
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 2)
        return ASWrapperLayoutSpec(layoutElement: node)
    }
    
}
