//
//  commentViewController.swift
//  Growers
//
//  Created by teranishidaina on 2021/3/2.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import UIKit

protocol commentView: AnyObject {
    
}

final class commentViewController: UIViewController {
    
    var presenter: commentViewPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension commentViewController: commentView {
    
}

