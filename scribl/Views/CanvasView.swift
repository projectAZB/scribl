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
    
    var lastPoint = CGPoint.zero
    var lastStroke: Stroke? = nil
    var strokeColor = UIColor.pureBlack()
    var strokeWidth: CGFloat = 10.0
    var moved = false
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        moved = false
        lastPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        moved = true
        let currentPoint = touch.location(in: self)
        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
    }
    
    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        canvasImageView.image?.draw(in: bounds)
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(strokeWidth)
        context.setStrokeColor(strokeColor.cgColor)
        context.strokePath()
        canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastStroke = Stroke(
            fromPoint: fromPoint,
            toPoint: toPoint,
            width: strokeWidth,
            color: strokeColor
        )
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !moved {
            drawLine(from: lastPoint, to: lastPoint)
        }
        delegate?.onStrokeEnded(stroke: lastStroke!)
    }
    
}
