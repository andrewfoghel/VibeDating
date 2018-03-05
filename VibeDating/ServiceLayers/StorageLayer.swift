//
//  StorageLayer.swift
//  VibeDating
//
//  Created by Andrew Foghel on 3/4/18.
//  Copyright © 2018 andrewfoghel. All rights reserved.
//

import Foundation
import Firebase

class StorageLayer {
    static let shared = StorageLayer()
    
    func saveImage(folderPath: String, image: UIImage, completion: @escaping (String?, Error?) -> ()) {
        let uuid = UUID().uuidString
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        Storage.storage().reference().child(folderPath).child(uuid).putData(uploadData, metadata: nil) { (metadata, error) in
            if let err = error {
                completion(nil, err)
                return
            }
            
            guard let downloadUrl = metadata?.downloadURL()?.absoluteString else { completion(nil, nil); return }
            completion(downloadUrl, nil)
            
        }
    }
    
}
