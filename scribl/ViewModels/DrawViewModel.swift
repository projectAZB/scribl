//
//  DrawViewModel.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation

class DrawViewModel: BaseViewModel {
    
    var drawing: Drawing = Drawing(email: UserManager.shared.userEmail!)
    
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
