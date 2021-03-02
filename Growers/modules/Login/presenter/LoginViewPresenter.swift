//
//  LoginViewPresenter.swift
//  Growers
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol LoginViewPresentation: AnyObject {
    func viewDidLoad()
    func didTapLogin(mail: String?, password: String?)
    func didTapSignup(mail: String?, password: String?)
    func textFieldisEmpty(state: SigninStates)
    func signInwithEmail(mail: String, password: String)
    func signUpwithEmail(mail: String, password: String)
}




final class LoginViewPresenter {
    
    private let view: LoginViewProtocol
    private let auth: AuthenticationProtocol
    private let router: LoginRouterProtocol
    private let interactor: LoginUsecase
    private let firestoreWrite: CloudFirebaseWriteProtocol
    
    init(router: LoginRouterProtocol,
         interactor: LoginUsecase, auth: AuthenticationProtocol, view: LoginViewProtocol, firestoreWrite: CloudFirebaseWriteProtocol) {
        self.view = view
        self.auth = auth
        self.firestoreWrite = firestoreWrite
        self.interactor = interactor
        self.router = router
    }
}

extension LoginViewPresenter: LoginViewPresentation {
    func signUpwithEmail(mail: String, password: String) {
        self.auth.signupWithEmail(mail: mail, password: password){result, uid in
            
            print(result)
            switch result{
            case .LoginSuccess:
                self.view.showProgress(state: result)
                self.firestoreWrite.signUp(uid: uid!)
                break
                
            case .LoginFaild:
                self.view.showProgress(state:  result)
                break
                
            default:
                break
            }
            
        }
    }
    
    
    func signInwithEmail(mail: String, password: String) {
        
        self.auth.sigiInWithEmail(mail: mail, password: password){result, uid in
            
            print(result)
            switch result{
            case .LoginSuccess:
                self.view.showProgress(state: result)
                self.firestoreWrite.login(uid: uid!)
                
                break
                
            case .LoginFaild:
                self.view.showProgress(state:  result)
                break
                
            default:
                break
            }
            
        }
    }
    
    func textFieldisEmpty(state: SigninStates) {
        self.view.textFieldisEmpty(state: state)
        self.view.showProgress(state: state)
        
    }
    
    func didTapLogin(mail: String?, password: String?) {
        guard  let mail = mail , let password = password else{
            return
        }
        self.view.showProgress(state: SigninStates.Login)
        self.interactor.login(mail: mail, password: password)
    }
    
    func didTapSignup(mail: String?, password: String?) {
        guard  let mail = mail , let password = password else{
            return
        }
        self.view.showProgress(state: SigninStates.Login)
        self.interactor.signUp(mail: mail, password: password)
    }
    
    
    func viewDidLoad() {
        
    }
}


