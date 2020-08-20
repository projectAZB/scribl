//
//  UserManager.swift
//  scribl
//
//  Created by Adam Bollard on 8/19/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import Firebase


class UserManager {
    
    static let shared = UserManager()
    
    private var authListener: AuthStateDidChangeListenerHandle?
    
    private var user: ScriblUser? {
        set(newValue) {
            UserDefaults.standard.set(newValue?.email, forKey: Keys.email)
        }
        get {
            if let email = UserDefaults.standard.string(forKey: Keys.email) {
                return ScriblUser(email: email)
            }
            return nil
        }
    }
    
    var userSignedIn: Bool {
        return Auth.auth().currentUser != nil && user != nil
    }
    
    var userEmail: String? {
        return Auth.auth().currentUser!.email
    }
    
    func createUser(
        email: String,
        password: String,
        completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            self.handleResult(authDataResult: authDataResult, error: error, completion: completion)
        }
    }
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            self.handleResult(authDataResult: authDataResult, error: error, completion: completion)
        }
    }
    
    private func handleResult(
        authDataResult: AuthDataResult?,
        error: Error?,
        completion: @escaping (_ success: Bool, _ errorMessage: String?) -> Void
    ) {
        guard error == nil else {
            completion(false, error!.localizedDescription)
            return
        }
        self.user = ScriblUser(email: authDataResult!.user.email!)
        completion(true, nil)
    }
}
