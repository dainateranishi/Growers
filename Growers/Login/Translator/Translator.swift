//
//  LoginTranslator.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol LoginTranslator {
    func translate(from model: LoginModel) -> LoginEntity
    func translate(from entity: LoginEntity) -> LoginModel
}


struct LoginTranslatorImpl: LoginTranslator {
   func translate(from model: LoginModel) -> LoginEntity {
       return LoginEntityImpl(id: model.id)
   }
   func translate(from entity: LoginEntity) -> LoginModel {
       return LoginModelImpl(id: entity.id)
   }
}
