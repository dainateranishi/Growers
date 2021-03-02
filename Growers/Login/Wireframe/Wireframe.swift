//
//  LoginWireframe.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import UIKit

protocol LoginWireframe: class {
    
}


class LoginWireframeImpl: LoginWireframe {
    private weak var viewController: UIViewController!
    
    init(
        viewController: UIViewController
        ) {
        self.viewController = viewController
    }
}
