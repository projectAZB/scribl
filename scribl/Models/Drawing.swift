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
    
    var strokes: [Stroke]
    let email: String
    
    init(email: String, strokes: [Stroke] = []) {
        self.email = email
        self.strokes = strokes
    }
    
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

extension Drawing {
    
    static func fromDict(dict: [String: Any]) -> Drawing {
        let email: String = dict["email"] as! String
        let strokes: [[String: Any]] = dict["strokes"] as! [[String : Any]]
        return Drawing(email: email, strokes: strokes.map({ (dict) -> Stroke in
            Stroke.fromDict(dict: dict)
        }))
    }
    
    func toDict() -> [String: Any] {
        return [
            "email": self.email,
            "strokes": self.strokes.map({ (stroke) -> [String : Any] in
                stroke.toDict()
            }),
        ]
    }
    
}
