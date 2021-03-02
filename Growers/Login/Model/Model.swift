//
//  LoginModel.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol LoginModel {
   var id: Int { get }
}


struct LoginModelImpl: LoginModel {
    let id: Int
}
