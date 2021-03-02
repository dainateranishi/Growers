import UIKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth
import SVProgressHUD

class SignupViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var ShowButton: UIButton!
    @IBOutlet weak var displaynameTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    let db = Firestore.firestore()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        ShowButton.rx.tap.subscribe(onNext: { [unowned self] in
            
            if let email = mailTextField.text,
               let password = passTextField.text,
               let displayname = displaynameTextField.text{
                if email.isEmpty {
                    SVProgressHUD.showError(withStatus: "Oops!")
                    mailTextField.layer.borderColor = UIColor.red.cgColor
                    return
                }
                if password.isEmpty {
                    SVProgressHUD.showError(withStatus: "Oops!")
                    passTextField.layer.borderColor = UIColor.red.cgColor
                    return
                }
                if displayname.isEmpty {
                    SVProgressHUD.showError(withStatus: "Oops!")
                    displaynameTextField.layer.borderColor = UIColor.red.cgColor
                    return
                }
                mailTextField.layer.borderColor = UIColor.black.cgColor
                passTextField.layer.borderColor = UIColor.black.cgColor
                displaynameTextField.layer.borderColor = UIColor.black.cgColor
                
                
                SVProgressHUD.show()
                
                // ユーザー作成
                Auth.auth().createUser(withEmail: email, password: password) { user, error in
                    if let error = error {
                        print(error)
                        SVProgressHUD.showError(withStatus: "Error!")
                        return
                    }
                    // ユーザーネームを設定
                    let user = Auth.auth().currentUser
                    if let user = user {
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.displayName = displayname
                        changeRequest.commitChanges { error in
                            if let error = error {
                                print(error)
                                SVProgressHUD.showError(withStatus: "Error!")
                                return
                            }
                            SVProgressHUD.showSuccess(withStatus: "Success!")
                            
                            let userID = user.uid
                            
                            self.db.collection("Users").document(userID).setData([
                                "name": displayname,
                                "createdAt": nowTimeString(),
                                "updatedAt": nowTimeString(),
                                "iconURL": NSNull(),
                                "LoginTime": nowTimeString()
                            ])
                            
                            let controller = HomeViewController.instantiate()
                            self.present(controller, animated: true, completion: nil)
                            
                            SVProgressHUD.dismiss()
                        }
                    }
                }
            }
        }).disposed(by: disposeBag)
        
        backButton.rx.tap.asDriver().throttle(.seconds(1), latest: false).drive(onNext: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
    }
}

