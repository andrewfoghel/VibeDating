//
//  AuthLayer.swift
//  VibeDating
//
//  Created by Andrew Foghel on 3/3/18.
//  Copyright © 2018 andrewfoghel. All rights reserved.
//

import UIKit
import Firebase

class AuthLayer {
    static let shared = AuthLayer()
    
    var myUser = Auth.auth().currentUser
    
    func createUser(email: String, password: String, name: String, image: UIImage, completion: @escaping (Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("There was an error creating the user: ", err.localizedDescription)
                completion(false)
                return
            }
            
            guard let user = user else { return }
            
            StorageLayer.shared.saveImage(folderPath: "profile_images", image: image, completion: { (downloadUrl, error) in
                if let err = error {
                    print("Error Saving Profile Image: ", err.localizedDescription)
                    return
                }
                
                guard let url = downloadUrl else { return }
                currentUser = MyUser(uid: user.uid, name: name, email: email, profileImageUrl: url)
                DatabaseLayer.shared.saveUserData(user: currentUser)
                completion(true)
            })
        }
    }
    
    func handleLogin(email: String, password: String, completion: @escaping (MyUser?, Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Error Signing In: ", err.localizedDescription)
                completion(nil, err)
            }
            guard let user = user else { completion(nil, nil); return }
            DatabaseLayer.shared.getCurrentUserData(uid: user.uid, completion: completion)
        }
    }
    
    func handleLogout(completion: @escaping () -> ()) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch {
            print("Failed to logout: ", error.localizedDescription)
        }
    }
    
    func getUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        DatabaseLayer.shared.getCurrentUserData(uid: uid) { (user, error) in
            if let err = error {
                print("Error getting users data: ", err.localizedDescription)
                return
            }
            
            guard let user = user else { return }
            currentUser = user
        }
    }
    
    
}


