//
//  UIColor+Scribl.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func pureWhite(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: alpha)
    }
    
    static func pureBlack(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: alpha)
    }
    
    static func whiteLilac() -> UIColor {
        return UIColor(red: 249.0/255.0, green: 250.0/255.0, blue: 252.0/255.0, alpha: 1.0)
    }
    
}
