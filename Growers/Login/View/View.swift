//
//  LoginView.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import UIKit

protocol LoginView: class {
    
}


class LoginViewController: UIViewController {
    
    private var presenter: LoginPresenter!
    
    func inject(
        presenter: LoginPresenter
        ) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LoginViewController: LoginView {
    
}
