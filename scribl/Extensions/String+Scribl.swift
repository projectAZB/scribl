//
//  String+Scribl.swift
//  scribl
//
//  Created by Adam Bollard on 8/20/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation


extension String {
    
    func toDateFromString(withOutputFormat outputFormat: String = DateFormats.dateTime) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat
        guard let date : Date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
    
}
