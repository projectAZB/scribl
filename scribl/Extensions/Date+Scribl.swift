//
//  UIDate+Scribl.swift
//  scribl
//
//  Created by Adam Bollard on 8/20/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation

extension Date {
    
    func toDateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.dateTime
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
}
