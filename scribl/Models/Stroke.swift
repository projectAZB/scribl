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
    let fromPoint: CGPoint // this point will hold point ratios
    let toPoint: CGPoint // this point will hold point ratios
    let width: CGFloat
    let color: UIColor
    let duration: TimeInterval
    
    static func newInstance(
        inView view: UIView,
        absoluteFromPoint: CGPoint,
        absoluteToPoint: CGPoint,
        width: CGFloat,
        color: UIColor,
        duration: TimeInterval
    ) -> Stroke {
        let fromPoint: CGPoint = CGPoint(x: absoluteFromPoint.x / view.bounds.width, y: absoluteFromPoint.y / view.bounds.height)
        let toPoint: CGPoint = CGPoint(x: absoluteToPoint.x / view.bounds.width, y: absoluteToPoint.y / view.bounds.height)
        return Stroke(fromPoint: fromPoint, toPoint: toPoint, width: width, color: color, duration: duration)
    }
    
    func draw(inView view: UIView) {
        view.layer.addSublayer(shapeLayer(inView: view))
    }
    
    func shapeLayer(inView view: UIView, strokeEnd: CGFloat = 1.0) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: fromPoint.x * view.bounds.width, y: fromPoint.y * view.bounds.height))
        path.addLine(to: CGPoint(x: toPoint.x * view.bounds.width, y: toPoint.y * view.bounds.height))
        
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

extension Stroke {
    
    static func fromDict(dict: [String: Any]) -> Stroke {
        let fromPointDict = dict["fromPoint"] as! [String : CGFloat]
        let toPointDict = dict["toPoint"] as! [String : CGFloat]
        let width = dict["width"] as! CGFloat
        let colorDict = dict["color"] as! [String : CGFloat]
        let duration = dict["duration"] as! TimeInterval
        
        return Stroke(
            fromPoint: CGPoint(x: fromPointDict["x"]!, y: fromPointDict["y"]!),
            toPoint: CGPoint(x: toPointDict["x"]!, y: toPointDict["y"]!),
            width: width,
            color: UIColor(red: colorDict["r"]!, green: colorDict["g"]!, blue: colorDict["b"]!, alpha: 1.0),
            duration: duration
        )
    }
    
    func toDict() -> [String: Any] {
        let rgb = self.color.toRGBTriple()
        return [
            "fromPoint": ["x": self.fromPoint.x, "y": self.fromPoint.y],
            "toPoint": ["x": self.toPoint.x, "y": self.toPoint.y],
            "width": self.width,
            "color": ["r": rgb.0, "g": rgb.1, "b": rgb.2],
            "duration": self.duration
        ]
    }
    
}
