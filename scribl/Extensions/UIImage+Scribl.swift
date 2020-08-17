//
//  UIImage+Scribl.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func drawIcon() -> UIImage? {
        return UIImage(named: "draw")
    }
    
    static func eraserIcon() -> UIImage? {
        return UIImage(named: "eraser")
    }
    
    static func eraserSelectedIcon() -> UIImage? {
        return UIImage(named: "eraser-selected")
    }
    
}
