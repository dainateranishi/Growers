//
//  Authentication.swift
//  Growers
//
//  Created by 寺西帝乃 on 2021/02/25.
//

import Foundation
import Firebase
import FirebaseAuth



protocol AuthenticationProtocol: AnyObject {
    func sigiInWithEmail(mail: String, password : String, completion: @escaping (SigninStates, String?) -> ())
    func signupWithEmail(mail: String, password : String, completion: @escaping (SigninStates, String?) -> ())
}

final class Authentication: AuthenticationProtocol{
    
    let auth: Auth
    
    init() {
        self.auth = Auth.auth()
    }
    
    
    func sigiInWithEmail(mail: String, password: String, completion: @escaping (SigninStates, String?) -> ()) {
        self.auth.signIn(withEmail: mail, password: password){user, error in
            if let error = error {
                print(error)
                completion(SigninStates.LoginFaild, nil)
            }else{
                print("login success")
                completion(SigninStates.LoginSuccess, user?.user.uid)
            }
        }
    }
    
    func signupWithEmail(mail: String, password: String, completion: @escaping (SigninStates, String?) -> ()) {
        self.auth.createUser(withEmail: mail, password: password){ user, error in
            if let error = error {
                print(error)
                completion(SigninStates.LoginFaild, nil)
            }else{
                print("login success")
                completion(SigninStates.LoginSuccess, user?.user.uid)
            }
        }
    }
}
