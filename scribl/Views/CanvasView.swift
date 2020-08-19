//
//  CanvasView.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit

protocol CanvasViewDelegate: class {
    func onStrokeEnded(stroke: Stroke)
}

class CanvasView: UIView {
    
    var lastPointTime: Date?
    var lastPoint = CGPoint.zero
    var lastStroke: Stroke? = nil
    var strokeColor = UIColor.pureBlack()
    var strokeWidth: CGFloat = 10.0
    var moved = false
    
    var playing: Bool = false {
        didSet {
            editable = !playing
        }
    }
    
    var editable: Bool = true {
        didSet {
            isUserInteractionEnabled = editable
        }
    }
    
    weak var delegate: CanvasViewDelegate? = nil
    
    private lazy var canvasImageView : UIImageView = {
        let canvasImageView = UIImageView()
        canvasImageView.translatesAutoresizingMaskIntoConstraints = false
        return canvasImageView
    }()
    
    convenience init() {
        self.init(frame: .zero)
        isUserInteractionEnabled = true
        configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        clipsToBounds = true
        layer.borderColor = UIColor.pureBlack().cgColor
        layer.cornerRadius = 4.0
        layer.borderWidth = 1.0
        backgroundColor = .pureWhite()
        
        self.addSubview(canvasImageView)
        
        NSLayoutConstraint.activate(
            [
                canvasImageView.leftAnchor.constraint(equalTo: leftAnchor),
                canvasImageView.topAnchor.constraint(equalTo: topAnchor),
                canvasImageView.rightAnchor.constraint(equalTo: rightAnchor),
                canvasImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
    
    func resetDrawing() {
        canvasImageView.layer.sublayers?.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        moved = false
        lastPoint = touch.location(in: self)
        lastPointTime = Date()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        moved = true
        let currentPoint = touch.location(in: self)
        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
        lastPointTime = Date()
    }
    
    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        lastStroke = Stroke(
            fromPoint: fromPoint,
            toPoint: toPoint,
            width: strokeWidth,
            color: strokeColor,
            duration: Date().timeIntervalSince(lastPointTime!)
        )
        drawStroke(stroke: lastStroke!)
        delegate?.onStrokeEnded(stroke: lastStroke!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !moved {
            drawLine(from: lastPoint, to: lastPoint)
        }
    }
    
    func playDrawing(strokes: [Stroke]) {
        resetDrawing()
        var animationInterval: TimeInterval = 0.0
        for stroke in strokes {
            let path = UIBezierPath()
            path.move(to: stroke.fromPoint)
            path.addLine(to: stroke.toPoint)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = stroke.color.cgColor
            shapeLayer.lineWidth = stroke.width
            shapeLayer.strokeEnd = 0.0
            shapeLayer.path = path.cgPath
            shapeLayer.lineCap = .round
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            animation.duration = stroke.duration
            animation.beginTime = CACurrentMediaTime() + animationInterval
            animationInterval += stroke.duration
            
            canvasImageView.layer.addSublayer(shapeLayer)
            
            shapeLayer.add(animation, forKey: nil)
        }
    }
    
    func shapeLayerFromStroke(stroke: Stroke) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: stroke.fromPoint)
        path.addLine(to: stroke.toPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = stroke.color.cgColor
        shapeLayer.lineWidth = stroke.width
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = .round
        return shapeLayer
    }
    
    func drawStroke(stroke: Stroke) {
        canvasImageView.layer.addSublayer(shapeLayerFromStroke(stroke: stroke))
    }
    
}
