//
//  commentViewPresenter.swift
//  Growers
//
//  Created by teranishidaina on 2021/3/2.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol commentViewPresentation: AnyObject {

    func viewDidLoad()    
}


final class commentViewPresenter {

    private weak var view: commentView?
    private let router: commentWireframe
    private let interactor: commentUsecase
    
    init(view: commentView,
         router: commentWireframe,
         interactor: commentUsecase) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension commentViewPresenter: commentViewPresentation {
    
    func viewDidLoad() {
        
    }
}

