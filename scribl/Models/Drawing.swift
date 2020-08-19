//
//  Drawing.swift
//  scribl
//
//  Created by Adam Bollard on 8/19/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit

struct Drawing {
    
    var strokes: [Stroke] = []
    
    var totalDuration: TimeInterval {
        return strokes.reduce(0.0) { (result, stroke) -> TimeInterval in
            result + stroke.duration
        }
    }
    
    func render(inView view: UIView) {
        for stroke in strokes {
            stroke.draw(inView: view)
        }
    }
    
    mutating func addStroke(_ stroke: Stroke) {
        strokes.append(stroke)
    }
    
    mutating func reset() {
        strokes.removeAll()
    }
    
}
