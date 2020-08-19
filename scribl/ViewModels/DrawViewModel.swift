//
//  DrawViewModel.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation

class DrawViewModel: BaseViewModel {
    
    var drawing: Drawing = Drawing()
    
    func saveDrawing() {
        // If there are strokes, save the drawing to the singleton
        Singleton.shared.drawings.append(drawing)
    }
    
}
