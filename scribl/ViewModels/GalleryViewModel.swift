//
//  GalleryViewModel.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation

protocol GalleryViewModelDelegate: class {
    func onDrawingsLoaded()
}

class GalleryViewModel: BaseViewModel {
    
    var drawings: [Drawing] = []
    
    weak var delegate: GalleryViewModelDelegate? = nil
    
    func getDrawings() {
        self.drawings.removeAll()
        DbManager.shared.db.collection("drawings").getDocuments { (querySnapshot, error) in
            guard error == nil else {
                print("Error getting documents \(error!.localizedDescription)")
                self.delegate?.onDrawingsLoaded()
                return
            }
            for document in querySnapshot!.documents {
                let drawing: Drawing = Drawing.fromDict(dict: document.data())
                self.drawings.append(drawing)
            }
            self.delegate?.onDrawingsLoaded()
        }
    }
    
}
