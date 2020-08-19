//
//  Stroke.swift
//  scribl
//
//  Created by Adam Bollard on 8/17/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit


struct Stroke {
    let fromPoint: CGPoint
    let toPoint: CGPoint
    let width: CGFloat
    let color: UIColor
    let duration: TimeInterval
    
    func shapeLayer(strokeEnd: CGFloat = 1.0) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: self.fromPoint)
        path.addLine(to: self.toPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = self.color.cgColor
        shapeLayer.lineWidth = self.width
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = strokeEnd
        return shapeLayer
    }
}
