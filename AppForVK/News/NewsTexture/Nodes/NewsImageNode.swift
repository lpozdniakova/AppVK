//
//  NewsImageNode.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 27/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewsImageNode: ASCellNode {
    private let resource: ImageNodeRepresentable
    private let photoImageNode = ASNetworkImageNode()
    
    init(resource: ImageNodeRepresentable) {
        self.resource = resource
        
        super.init()
        setupSubnodes()
    }
    
    private func setupSubnodes() {
        photoImageNode.url = resource.url
        photoImageNode.contentMode = .scaleAspectFill
        photoImageNode.shouldRenderProgressImages = true
        
        addSubnode(photoImageNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        photoImageNode.style.preferredSize = CGSize(width: width, height: width*resource.aspectRatio)
        return ASWrapperLayoutSpec(layoutElement: photoImageNode)
    }
}
