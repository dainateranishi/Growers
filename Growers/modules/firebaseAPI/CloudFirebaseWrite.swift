//
//  cCloudFirebase.swift
//  Growers
//
//  Created by 寺西帝乃 on 2021/03/01.
//

import Foundation
import Firebase
import FirebaseAuth

protocol CloudFirebaseWriteProtocol {
    func login(uid: String)
    func signUp(uid: String)
}

final class CloudFirebaseWrite : CloudFirebaseWriteProtocol{
    
    private let db: Firebase.Firestore
    
    init() {
        self.db = Firestore.firestore()
    }
    
    func login(uid: String) {
        self.db.collection("Users").document(uid).updateData([
            "loginTime": nowTimeString()
        ]){error in
            if let error = error{
                print(error)
            }else{
                print("success")
            }
        }
    }
    
    func signUp(uid: String) {
        self.db.collection("Users").document(uid).setData([
            "name": uid,
            "iconURL": NSNull(),
            "createdAt":nowTimeString(),
            "updatedAt": nowTimeString(),
            "loginTime": nowTimeString()
        ]){error in
            if let error = error{
                print(error)
            }else{
                print("success")
            }
        }
    }
    
    
}
