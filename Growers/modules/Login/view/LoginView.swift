//
//  LoginViewController.swift
//  Growers
//
//  Created by teranishidaina on 2021/2/25.
//  Copyright © 2021 teranishidaina. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift
import RxCocoa

protocol LoginViewProtocol: Transitioner{
    func showProgress(state: SigninStates)
    func textFieldisEmpty(state: SigninStates)
    func inject(presenter: LoginViewPresentation)
}

final class LoginView: UIViewController {
    
    private var presenter: LoginViewPresentation!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.addTarget(self,action: #selector(self.tapLogin(_ :)),for: .touchUpInside)
        self.signupButton.addTarget(self,action: #selector(self.tapSignUp(_ :)),for: .touchUpInside)
    }
    
    func inject(presenter: LoginViewPresentation){
        self.presenter = presenter
    }

    @objc func tapLogin(_ sender: UIButton) {
        self.presenter.didTapLogin(mail: self.mailTextField.text, password: self.passwordTextField.text)
    }
    @objc func tapSignUp(_ sender: UIButton) {
        self.presenter.didTapSignup(mail: self.mailTextField.text, password: self.passwordTextField.text)
    }
}

extension LoginView : LoginViewProtocol{
    
    func textFieldisEmpty(state: SigninStates) {
        switch state {
        case .mailisEmpty:
            self.mailTextField.layer.borderColor = UIColor.red.cgColor
        case .passwordisEmpty:
            self.passwordTextField.layer.borderColor = UIColor.red.cgColor
        default:
            break
        }
    }
    
    func showProgress(state: SigninStates) -> Void {
        
        switch state {
        case .Login:
            SVProgressHUD.show(withStatus: state.message)
        case .LoginSuccess:
            SVProgressHUD.showSuccess(withStatus: state.message)
        default:
            SVProgressHUD.showError(withStatus: state.message)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            SVProgressHUD.dismiss()
        }
    }
    
}

