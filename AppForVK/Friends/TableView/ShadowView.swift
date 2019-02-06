//
//  ShadowView.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 12/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit

@IBDesignable class ShadowView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 22 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 11 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAShapeLayer).cornerRadius = cornerRadius
        (layer as! CAShapeLayer).shadowColor = shadowColor.cgColor
        (layer as! CAShapeLayer).shadowOpacity = shadowOpacity
        (layer as! CAShapeLayer).shadowRadius = shadowRadius
        (layer as! CAShapeLayer).shadowOffset = shadowOffset
    }
}
