//
//  LoginUseCase.swift
//  
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import Foundation

protocol LoginUseCase {
    func fetch(_ closure: (LoginModel) -> Void) throws 
}


struct LoginUseCaseImpl: LoginUseCase {
    private let repository: LoginRepository
    private let translator: LoginTranslator
    
    init(
        repository: LoginRepository, 
        translator: LoginTranslator
        ) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetch(_ closure: (LoginModel) -> Void) throws  {
        try repository.fetch { 
           closure(
              translator.translate(from: $0)
           )
      }
    }
}
