//
//  LoginInteractor.swift
//  Growers
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol LoginUsecase: AnyObject {
    func login(mail: String, password:String)
    func signUp(mail: String, password:String)
}

enum SigninStates {
    case mailisEmpty
    case passwordisEmpty
    case Login
    case LoginSuccess
    case LoginFaild
    
    var message: String{
        switch self {
        case .mailisEmpty:
            return "メールアドレスが入力されていません"
        case .passwordisEmpty:
            return "パスワードが入力されていません"
        case .LoginSuccess:
            return "ログイン成功"
        case .LoginFaild:
            return "ログイン失敗"
        case .Login:
            return "Login..."
        }
    }
}



final class LoginInteractor {
    private weak var presenter: LoginViewPresentation?
    
    init() {
    }
    
    func inject(presenter: LoginViewPresentation){
        self.presenter = presenter
    }
}

extension LoginInteractor: LoginUsecase {
    func signUp(mail: String, password: String) {
        guard !mail.isEmpty else{
            self.presenter?.textFieldisEmpty(state: SigninStates.mailisEmpty)
            return
        }
        
        guard !password.isEmpty else{
            self.presenter?.textFieldisEmpty(state: SigninStates.passwordisEmpty)
            return
        }
        
        self.presenter?.signUpwithEmail(mail: mail, password: password)
    }
    
    func login(mail: String, password: String) {
        guard !mail.isEmpty else{
            self.presenter?.textFieldisEmpty(state: SigninStates.mailisEmpty)
            return
        }
        
        guard !password.isEmpty else{
            self.presenter?.textFieldisEmpty(state: SigninStates.passwordisEmpty)
            return
        }
        
        self.presenter?.signInwithEmail(mail: mail, password: password)
        
        
    }
    
    
}

