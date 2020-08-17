//
//  ToolbarView.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit


protocol ToolbarViewDelegate: class {
    func onEraserToggled(on: Bool)
}


class ToolbarView: UIView {
    
    var selectedColor: UIColor = .pureBlack()
    
    weak var delegate: ToolbarViewDelegate? = nil
    
    private var eraserOn: Bool = false {
        didSet {
            let eraserImage: UIImage? = eraserOn ? .eraserSelectedIcon() : .eraserIcon()
            eraserButton.setImage(eraserImage, for: .normal)
        }
    }
    
    private lazy var eraserButton: UIButton = {
        let eraserButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        eraserButton.setImage(.eraserIcon(), for: .normal)
        eraserButton.imageEdgeInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        eraserButton.addTarget(self, action: #selector(eraserButtonPressed), for: .touchUpInside)
        eraserButton.translatesAutoresizingMaskIntoConstraints = false
        return eraserButton
    }()
    
    convenience init() {
        self.init(frame: .zero)
        configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        backgroundColor = .pureWhite()
        layer.borderColor = UIColor.pureBlack().cgColor
        layer.cornerRadius = 4.0
        layer.borderWidth = 1.0
        
        addSubview(eraserButton)
        
        NSLayoutConstraint.activate(
            [
                eraserButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -Dimensions.margin16),
                eraserButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }
    
    @objc func eraserButtonPressed() {
        eraserOn = !eraserOn
        delegate?.onEraserToggled(on: eraserOn)
    }
    
}
