//
//  homeViewController.swift
//  Growers
//
//  Created by teranishidaina on 2021/3/2.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import UIKit

protocol homeView: AnyObject {
    
}

final class homeViewController: UIViewController {
    
    var presenter: homeViewPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension homeViewController: homeView {
    
}

