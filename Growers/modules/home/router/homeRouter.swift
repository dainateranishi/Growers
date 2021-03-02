//
//  homeRouter.swift
//  Growers
//
//  Created by teranishidaina on 2021/3/2.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import UIKit

protocol homeWireframe: AnyObject {
    
}

final class homeRouter {
    
    private unowned let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = homeViewController()
        let router = homeRouter(viewController: view)
        let interactor = homeInteractor()
        let presenter = homeViewPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        
        return view
    }
}

extension homeRouter: homeWireframe {
    
}
