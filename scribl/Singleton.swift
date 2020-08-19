//
//  Singleton.swift
//  scribl
//
//  Created by Adam Bollard on 8/19/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation

class Singleton {
    
    static let shared = Singleton()
    
    var drawings: [Drawing] = []
    
}
