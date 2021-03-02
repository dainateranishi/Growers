//
//  LoginRouter.swift
//  Growers
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    
}

final class LoginRouter : LoginRouterProtocol{
    
    private var viewController: LoginViewProtocol
    
    init(viewcontroller: LoginViewProtocol) {
        self.viewController = viewcontroller
    }
    
    func assembleModules(){
        let auth = Authentication()
        let firestoreWrite = CloudFirebaseWrite()
        let loginInteractor = LoginInteractor()
        let loginPresenter = LoginViewPresenter(router: self, interactor: loginInteractor, auth: auth, view: self.viewController, firestoreWrite: firestoreWrite)
        loginInteractor.inject(presenter: loginPresenter)
        self.viewController.inject(presenter: loginPresenter)
    }
    
}
