//
//  LoginEntity.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol LoginEntity {
    var id: Int { get }
}


struct LoginEntityImpl: LoginEntity {
    let id: Int
}
