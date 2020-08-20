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
    func onPlayDrawingEnded()
}

class CanvasView: UIView {
    
    var lastAnimation: CAAnimation?
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
        lastStroke = Stroke.newInstance(
            inView: self,
            absoluteFromPoint: fromPoint,
            absoluteToPoint: toPoint,
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
    
    func playDrawing(_ drawing: Drawing) {
        // If the drawing is empty, call delegate and return
        if drawing.strokes.count == 0 {
            delegate?.onPlayDrawingEnded()
            return
        }
        resetDrawing()
        var animationInterval: TimeInterval = 0.0
        let strokeCount: Int = drawing.strokes.count
        for index in 0..<strokeCount {
            let stroke = drawing.strokes[index]
            
            let shapeLayer = stroke.shapeLayer(inView: self, strokeEnd: 0.0)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            animation.duration = stroke.duration
            animation.beginTime = CACurrentMediaTime() + animationInterval
            animationInterval += stroke.duration
            
            if index == strokeCount - 1 {
                setLastAnimation(animation)
            }
            
            canvasImageView.layer.addSublayer(shapeLayer)
            
            shapeLayer.add(animation, forKey: nil)
        }
    }
    
    func drawStroke(stroke: Stroke) {
        stroke.draw(inView: canvasImageView)
    }
    
    func cleanup() {
        canvasImageView.layer.sublayers?.removeAll()
    }
    
    func setLastAnimation(_ animation: CAAnimation) {
        lastAnimation = animation
        lastAnimation!.delegate = self
    }
    
    func removeLastAnimationDelegate() {
        lastAnimation?.delegate = nil
        lastAnimation = nil
    }
    
    func render(drawing: Drawing) {
        canvasImageView.layoutIfNeeded()
        drawing.render(inView: canvasImageView)
    }
    
}

extension CanvasView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delegate?.onPlayDrawingEnded()
        removeLastAnimationDelegate()
    }
    
}
