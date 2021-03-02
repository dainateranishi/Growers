//
//  LoginRepository.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol LoginRepository {
    func fetch(_ closure: (LoginEntity) -> Void) throws 
}


struct LoginRepositoryImpl: LoginRepository {
    private let dataStore: LoginDataStore
    
    init(
        dataStore: LoginDataStore
        ) {
        self.dataStore = dataStore
    }
    
    func fetch(_ closure: (LoginEntity) -> Void) throws  {
        return try dataStore.fetch(closure)
    }
}
