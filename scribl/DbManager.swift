//
//  DbManager.swift
//  scribl
//
//  Created by Adam Bollard on 8/20/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import Firebase


class DbManager {
    
    static let shared = DbManager()
    
    let db: Firestore
    
    private init() {
        let settings = FirestoreSettings()
        // Create local persistence store in lieu of core data
        settings.isPersistenceEnabled = true
        settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
        self.db = Firestore.firestore()
        self.db.settings = settings
    }
}
