//
//  DrawViewModel.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation

enum DrawViewType {
    case create, display
}

class DrawViewModel: BaseViewModel {
    
    let type: DrawViewType
    var drawing: Drawing
    
    init(type: DrawViewType, drawing: Drawing = Drawing(email: UserManager.shared.userEmail!)) {
        self.type = type
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
    
    func deleteDrawing() {
        DbManager.shared.db.collection("drawings").document(drawing.documentID!).delete { (error) in
            guard error == nil else {
                print("Error deleting document \(self.drawing.documentID)")
                return
            }
            print("Deleted document \(self.drawing.documentID!)")
        }
    }
    
}
