//
//  DrawViewModel.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation

class DrawViewModel: BaseViewModel {
    
    var canvasStrokes: [Stroke] = []
    
    func addStroke(stroke: Stroke) {
        canvasStrokes.append(stroke)
    }
    
    func resetCanvas() {
        canvasStrokes.removeAll()
    }
    
}
