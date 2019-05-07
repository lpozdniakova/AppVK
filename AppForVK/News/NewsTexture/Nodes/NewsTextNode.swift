//
//  NewsTextNode.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 27/04/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import AsyncDisplayKit

let kLinkAttributeName = NSAttributedString.Key(rawValue: "TextLinkAttributeName")

class NewsTextNode: ASCellNode {
    
    private var _urlDetector: NSDataDetector?
    
    var urlDetector: NSDataDetector? {
        if _urlDetector == nil {
            _urlDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        }
        return _urlDetector
    }
    
    
    //MARK: - Properties
    private let text: String
    private let textNode = ASTextNode()
    
    init(text: String) {
        self.text = text
        super.init()
        backgroundColor = .clear
        setupSubnodes()
    }
    
    private func setupSubnodes() {
        
        let attrString = NSMutableAttributedString(string: text, attributes: TextStyles.postStyle)
        
        urlDetector?.enumerateMatches(in: attrString.string, options: [], range: NSMakeRange(0, attrString.string.count), using: { (result, flags, stop) in
            if result?.resultType == NSTextCheckingResult.CheckingType.link {
                
                var linkAttributes = TextStyles.postLinkStyle
                linkAttributes[kLinkAttributeName] = URL(string: (result?.url?.absoluteString)!)
                
                attrString.addAttributes(linkAttributes, range: (result?.range)!)
            }
        })
        
        // Configure node to support tappable links
        textNode.delegate = self
        textNode.isUserInteractionEnabled = true
        textNode.linkAttributeNames = [kLinkAttributeName.rawValue]
        textNode.attributedText = attrString
        //textNode.passthroughNonlinkTouches = true   // passes touches through when they aren't on a link
        addSubnode(textNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 2)
        let textWithInset = ASInsetLayoutSpec(insets: insets, child: textNode)
        return ASWrapperLayoutSpec(layoutElement: textWithInset)
    }

}

extension NewsTextNode: ASTextNodeDelegate {
    
    func textNode(_ textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: Any, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode, tappedLinkAttribute attribute: String, value: Any, at point: CGPoint, textRange: NSRange) {
        guard let url = value as? URL else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
}
