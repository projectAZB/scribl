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
    private let date: Date
    
    init(email: String, date: Date? = nil, strokes: [Stroke] = []) {
        self.email = email
        self.strokes = strokes
        self.date = date ?? Date()
    }
    
    var totalDuration: TimeInterval {
        return strokes.reduce(0.0) { (result, stroke) -> TimeInterval in
            result + stroke.duration
        }
    }
    
    var dateString: String {
        return date.toDateTimeString()
    }
    
    var usernameDuration: String {
        let usernameFromEmail = email.components(separatedBy: "@")[0]
        let totalDurationRounded = round(100 * totalDuration) / 100
        return "\(usernameFromEmail), \(totalDurationRounded)s"
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
        let dateString: String = dict["date"] as! String
        let date: Date = dateString.toDateFromString()!
        return Drawing(email: email, date: date, strokes: strokes.map({ (dict) -> Stroke in
            Stroke.fromDict(dict: dict)
        }))
    }
    
    func toDict() -> [String: Any] {
        return [
            "email": self.email,
            "strokes": self.strokes.map({ (stroke) -> [String : Any] in
                stroke.toDict()
            }),
            "date": self.date.toDateTimeString()
        ]
    }
    
}
