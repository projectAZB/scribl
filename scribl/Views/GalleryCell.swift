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
    
    static let labelHeight: CGFloat = 24.0
    let font: UIFont = UIFont(name: "Helvetica-Light", size: 13.0)!
    
    var drawing: Drawing? {
        didSet {
            if let drawing = drawing {
                drawing.render(inView: canvasImageView)
                userDurationLabel.text = drawing.usernameDuration
                dateCreatedLabel.text = drawing.dateString
            }
        }
    }
    
    lazy var userDurationLabel: UILabel = {
        let userDurationLabel = UILabel()
        userDurationLabel.font = font
        userDurationLabel.textColor = .pureBlack()
        userDurationLabel.textAlignment = .left
        userDurationLabel.minimumScaleFactor = 0.5
        userDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        return userDurationLabel
    }()
    
    lazy var canvasImageView: UIImageView = {
        let canvasImageView = UIImageView()
        canvasImageView.layer.borderColor = UIColor.pureBlack().cgColor
        canvasImageView.layer.cornerRadius = 4.0
        canvasImageView.layer.borderWidth = 1.0
        canvasImageView.clipsToBounds = true
        canvasImageView.translatesAutoresizingMaskIntoConstraints = false
        return canvasImageView
    }()
    
    lazy var dateCreatedLabel: UILabel = {
        let userDurationLabel = UILabel()
        userDurationLabel.font = font
        userDurationLabel.textColor = .pureBlack()
        userDurationLabel.textAlignment = .left
        userDurationLabel.minimumScaleFactor = 0.5
        userDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        return userDurationLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .pureWhite()
        
        contentView.addSubview(userDurationLabel)
        contentView.addSubview(canvasImageView)
        contentView.addSubview(dateCreatedLabel)
        
        NSLayoutConstraint.activate(
            [
                userDurationLabel.leftAnchor.constraint(equalTo: leftAnchor),
                userDurationLabel.topAnchor.constraint(equalTo: topAnchor),
                userDurationLabel.rightAnchor.constraint(equalTo: rightAnchor),
                userDurationLabel.heightAnchor.constraint(equalToConstant: GalleryCell.labelHeight),
                
                canvasImageView.leftAnchor.constraint(equalTo: leftAnchor),
                canvasImageView.topAnchor.constraint(equalTo: userDurationLabel.bottomAnchor),
                canvasImageView.rightAnchor.constraint(equalTo: rightAnchor),
                
                dateCreatedLabel.leftAnchor.constraint(equalTo: leftAnchor),
                dateCreatedLabel.topAnchor.constraint(equalTo: canvasImageView.bottomAnchor),
                dateCreatedLabel.rightAnchor.constraint(equalTo: rightAnchor),
                dateCreatedLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                dateCreatedLabel.heightAnchor.constraint(equalToConstant: GalleryCell.labelHeight)
            ]
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
