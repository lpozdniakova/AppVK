//
//  CloudView.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 29/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//
import UIKit

final class CloudView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = makeCloudPath()
        
        let cloudLayer = CAShapeLayer()
        cloudLayer.path = path.cgPath
        
        cloudLayer.lineWidth = 4.0
        cloudLayer.strokeColor = UIColor.vk_color.cgColor
        cloudLayer.fillColor = UIColor.clear.cgColor
        
        let cloudGrayLayer = CAShapeLayer()
        cloudGrayLayer.path = path.cgPath
        
        cloudGrayLayer.lineWidth = 2.0
        cloudGrayLayer.strokeColor = UIColor.lightGray.cgColor
        cloudGrayLayer.fillColor = UIColor.clear.cgColor
        
        cloudLayer.addSublayer(cloudGrayLayer)
        self.layer.addSublayer(cloudLayer)
        
        //MARK: - Animations
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.duration = 2
        //strokeStartAnimation.autoreverses = true
        strokeStartAnimation.repeatCount = .infinity
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.duration = 2
        //strokeEndAnimation.autoreverses = true
        strokeEndAnimation.repeatCount = .infinity
        
        let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
        followPathAnimation.path = path.cgPath
        followPathAnimation.calculationMode = CAAnimationCalculationMode.paced
        followPathAnimation.duration = 2
        //followPathAnimation.autoreverses = true
        followPathAnimation.repeatCount = .infinity
        
        let group = CAAnimationGroup()
        group.animations = [strokeEndAnimation, strokeStartAnimation]
        group.duration = 4
        //group.autoreverses = true
        group.repeatCount = .infinity
        
        //cloudGrayLayer.add(group, forKey: nil)
        cloudLayer.add(strokeEndAnimation, forKey: nil)
    }
    
    private func makeCloudPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 69, y: 66))
        path.addLine(to: CGPoint(x: 27, y: 66))
        path.addArc(withCenter: CGPoint(x: 27, y: 58), radius: 8, startAngle: .pi/2, endAngle: -.pi/3, clockwise: true)
        path.addArc(withCenter: CGPoint(x: 49, y: 56), radius: 20, startAngle: .pi/0.9, endAngle: -.pi/5, clockwise: true)
        path.addArc(withCenter: CGPoint(x: 71, y: 55), radius: 12, startAngle: -.pi/1.4, endAngle: .pi/3, clockwise: true)
        path.close()
        
        return path
    }
}
