//
//  LoginModel.swift
//  Growers
//
//  Created by 寺西帝乃 on 2021/02/21.
//

import Foundation
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginModel{
    
    let db = Firestore.firestore()
    
    init() {
    }
    
    func login(email: String, password: String)->Bool{
        var success:Bool = false
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error {
                print(error)
                success = false
            }else{
                if let user = Firebase.Auth.auth().currentUser{
                    let userID = user.uid
                    self.writeLoginTime(uid: userID)
                }
            }
        }
        
        return success
    }
    
    private func writeLoginTime(uid: String)->Bool{
        var success: Bool = false
        
        
        self.db.collection("Users").document(uid).setData([
            "LoginTime": nowTimeString()
        ]){error in
            if let error = error{
                success = false
                print(error)
            }else{
                success = true
            }
        }
        
        return success
    }
}
