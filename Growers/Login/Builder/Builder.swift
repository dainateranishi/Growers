//
//  LoginBuilder.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import UIKit

protocol LoginBuilder {
    func build() -> UIViewController
}


struct LoginBuilderImpl: LoginBuilder {
    func build() -> UIViewController {
        let viewController = LoginViewController()
        viewController.inject(
            presenter: LoginPresenterImpl(
                view: viewController,
                wireframe: LoginWireframeImpl(
                    viewController: viewController
                ),
                useCase: LoginUseCaseImpl(
                    repository: LoginRepositoryImpl (
                        dataStore: LoginDataStoreImpl()
                    ),
                    translator: LoginTranslatorImpl()
                )
            )
        )
        return viewController
    }
}
