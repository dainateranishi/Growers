//
//  commentRouter.swift
//  Growers
//
//  Created by teranishidaina on 2021/3/2.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import UIKit

protocol commentWireframe: AnyObject {
    
}

final class commentRouter {
    
    private unowned let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = commentViewController()
        let router = commentRouter(viewController: view)
        let interactor = commentInteractor()
        let presenter = commentViewPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        
        return view
    }
}

extension commentRouter: commentWireframe {
    
}
