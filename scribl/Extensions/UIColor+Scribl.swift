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
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: alpha)
    }
    
    static func pureBlack(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: alpha)
    }
    
    static func whiteLilac() -> UIColor {
        return UIColor(red: 0.97, green: 0.98, blue: 0.99, alpha: 1.0)
    }
    
    static func yvesBlue() -> UIColor {
        return UIColor(red: 0.1, green: 0.18, blue: 0.65, alpha: 1.0)
    }
    
    static func softGreen() -> UIColor {
        return UIColor(red: 0.17, green: 0.61, blue: 0.25, alpha: 1.0)
    }
    
    static func violetEggplant() -> UIColor {
        return UIColor(red: 0.53, green: 0.09, blue: 0.60, alpha: 1.0)
    }
    
    static func zestOrange() -> UIColor {
        return UIColor(red: 0.90, green: 0.53, blue: 0.12, alpha: 1.0)
    }
    
    static func cadmiumRed() -> UIColor {
        return UIColor(red: 0.90, green: 0.04, blue: 0.12, alpha: 1.0)
    }
    
}
