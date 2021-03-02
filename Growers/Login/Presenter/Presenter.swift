//
//  LoginPresenter.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol LoginPresenter: class {
    
}


class LoginPresenterImpl: LoginPresenter {
    private weak var view: LoginView?
    private let wireframe: LoginWireframe
    private let useCase: LoginUseCase
    
    init(
        view: LoginView,
        wireframe: LoginWireframe,
        useCase: LoginUseCase
        ) {
        self.view = view
        self.useCase = useCase
        self.wireframe = wireframe
    }
}
