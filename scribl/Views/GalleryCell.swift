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
    
    var drawing: Drawing? {
        didSet {
            drawing?.render(inView: canvasImageView)
        }
    }
    
    private lazy var canvasImageView: UIImageView = {
        let canvasImageView = UIImageView()
        canvasImageView.layer.borderColor = UIColor.pureBlack().cgColor
        canvasImageView.layer.cornerRadius = 4.0
        canvasImageView.layer.borderWidth = 1.0
        canvasImageView.clipsToBounds = true
        canvasImageView.translatesAutoresizingMaskIntoConstraints = false
        return canvasImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .pureWhite()
        
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
