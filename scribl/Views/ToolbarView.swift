//
//  ToolbarView.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit



class ToolbarView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
        layer.borderColor = UIColor.pureBlack().cgColor
        layer.cornerRadius = 4.0
        layer.borderWidth = 1.0
        backgroundColor = .pureWhite()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
