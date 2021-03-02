//import UIKit
//import RxCocoa
//import RxSwift
//import Firebase
//import FirebaseAuth
//import SVProgressHUD
//
//class LoginViewController: UIViewController {
//    
//    @IBOutlet weak var mailTextField: UITextField!
//    @IBOutlet weak var passTextField: UITextField!
//    @IBOutlet weak var ShowButton: UIButton!
//    let db = Firestore.firestore()
//    let loginModel = LoginModel()
//    
//    
//    private var disposeBag = DisposeBag()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        bind()
//    }
//    
//    private func bind() {
//        ShowButton.rx.tap.subscribe(onNext: { [unowned self] in
//            
//            if let email = mailTextField.text,
//               let password = passTextField.text{
//                if email.isEmpty {
//                    SVProgressHUD.showError(withStatus: "Oops!")
//                    mailTextField.layer.borderColor = UIColor.red.cgColor
//                    return
//                }
//                if password.isEmpty {
//                    SVProgressHUD.showError(withStatus: "Oops!")
//                    passTextField.layer.borderColor = UIColor.red.cgColor
//                    return
//                }
//                mailTextField.layer.borderColor = UIColor.black.cgColor
//                passTextField.layer.borderColor = UIColor.black.cgColor
//                
//                
//                SVProgressHUD.show()
//                
//                Auth.auth().signIn(withEmail: email, password: password) { user, error in
//                    if let error = error {
//                        print(error)
//                        SVProgressHUD.showError(withStatus: "Error")
//                    }else{
//                        if let user = Firebase.Auth.auth().currentUser{
//                            let userID = user.uid
//                            self.db.collection("Users").document(userID).setData([
//                                "LoginTime": nowTimeString()
//                            ]){error in
//                                if let error = error{
//                                    print(error)
//                                    SVProgressHUD.showError(withStatus: "Error")
//                                }else{
//                                    
//                                    let controller = HomeViewController.instantiate()
//                                    self.present(controller, animated: true, completion: nil)
//                                    SVProgressHUD.showError(withStatus: "Success")
//                                }
//                            }
//                            
//                        }
//                    }
//                }
//                
//            }
//        }).disposed(by: disposeBag)
//    }
//}
//
//
