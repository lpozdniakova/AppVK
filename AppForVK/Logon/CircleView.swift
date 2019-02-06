//
//  CircleView.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 23/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit

class circleView: UIView {
    
    var cornerRadius: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAShapeLayer).cornerRadius = cornerRadius
    }
}

