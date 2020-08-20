//
//  DrawViewModel.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation

class DrawViewModel: BaseViewModel {
    
    var drawing: Drawing
    
    init(drawing: Drawing = Drawing(email: UserManager.shared.userEmail!)) {
        self.drawing = drawing
    }
    
    func saveDrawing() {
        DbManager.shared.db.collection("drawings").addDocument(data: drawing.toDict()) { error in
            guard error == nil else {
                print("Error adding document: \(error!.localizedDescription)")
                return
            }
            print("Document added")
        }
    }
    
}
