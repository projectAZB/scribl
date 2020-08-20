//
//  ErrorAlertFactory.swift
//  scribl
//
//  Created by Adam Bollard on 8/20/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit


struct ErrorAlertFactory {
    
    static func create(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            
        }))
        return alert
    }
    
}
