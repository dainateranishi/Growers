//
//  AppRouter.swift
//  Growers
//
//  Created by 寺西帝乃 on 2021/03/02.
//

import Foundation
import UIKit


protocol AppRouterProtocol {
    func showLoginView()
    func showHomeView()
    func showNoteView()
    func showSettingView()
}

final class AppRouter: AppRouterProtocol{
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showLoginView() {
        let loginView = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! LoginView
        let loginRouter = LoginRouter(viewcontroller: loginView)
        loginRouter.assembleModules()
        let navigationController = UINavigationController(rootViewController: loginView)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showHomeView() {
    }
    
    func showNoteView() {
    }
    
    func showSettingView() {
    }
    
    

}
