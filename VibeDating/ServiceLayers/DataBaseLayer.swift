//
//  DataBaseLayer.swift
//  VibeDating
//
//  Created by Andrew Foghel on 3/3/18.
//  Copyright © 2018 andrewfoghel. All rights reserved.
//

import UIKit
import Firebase

class DatabaseLayer {
    static let shared = DatabaseLayer()
    
    func saveUserData(user: MyUser) {
        guard let uid = user.uid else { return }
        
        Database.database().reference().child("users").child(uid).updateChildValues(user.asJSON, withCompletionBlock: { (error, _) in
            if let err = error {
                print("Error saving user data: ", err.localizedDescription)
                return
            }
        })
    }
    
    func getCurrentUserData(uid: String, completion: @escaping (MyUser?, Error?) -> ()){
        var user: MyUser?
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                user = MyUser(key: snapshot.key, dictionary: dictionary)
                completion(user, nil)
            }
        }) { (err) in
            print("Error fetching user data: ", err.localizedDescription)
            completion(nil, err)
        }
    }
    
    func saveUserDatingImage(image: UIImage) {
        StorageLayer.shared.saveImage(folderPath: "dating_profile_images", image: image) { (downloadUrl, error) in
            if let err = error {
                print("Error Saving additional profile image: ", err.localizedDescription)
            }
            
            //Save user image here
            
            
        }
    }
    
    
}
