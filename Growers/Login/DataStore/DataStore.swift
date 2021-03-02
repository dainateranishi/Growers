//
//  LoginDataStore.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol LoginDataStore {
    func fetch(_ closure: (LoginEntity) -> Void) throws 
}


struct LoginDataStoreImpl: LoginDataStore {
    func fetch(_ closure: (LoginEntity) -> Void) throws  {
        // you can write get entity method
    }
}
