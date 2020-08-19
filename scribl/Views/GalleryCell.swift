//
//  GalleryCell.swift
//  scribl
//
//  Created by Adam Bollard on 8/19/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit


class GalleryCell: UICollectionViewCell {
    
    private var drawing: Drawing?
    
    private lazy var canvasImageView: UIImageView = {
        let canvasImageView = UIImageView()
        canvasImageView.layer.borderColor = UIColor.pureBlack().cgColor
        canvasImageView.layer.cornerRadius = 4.0
        canvasImageView.layer.borderWidth = 1.0
        canvasImageView.clipsToBounds = true
        canvasImageView.translatesAutoresizingMaskIntoConstraints = false
        return canvasImageView
    }()
    
    convenience init(drawing: Drawing) {
        self.init(frame: .zero)
        
        
        
        contentView.addSubview(canvasImageView)
        
        NSLayoutConstraint.activate(
            [
                canvasImageView.leftAnchor.constraint(equalTo: leftAnchor),
                canvasImageView.topAnchor.constraint(equalTo: topAnchor),
                canvasImageView.rightAnchor.constraint(equalTo: rightAnchor),
                canvasImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
