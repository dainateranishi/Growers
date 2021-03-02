//
//  homeViewPresenter.swift
//  Growers
//
//  Created by teranishidaina on 2021/3/2.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol homeViewPresentation: AnyObject {

    func viewDidLoad()    
}


final class homeViewPresenter {

    private weak var view: homeView?
    private let router: homeWireframe
    private let interactor: homeUsecase
    
    init(view: homeView,
         router: homeWireframe,
         interactor: homeUsecase) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension homeViewPresenter: homeViewPresentation {
    
    func viewDidLoad() {
        
    }
}

