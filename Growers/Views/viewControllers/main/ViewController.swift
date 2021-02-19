import UIKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var ShowButton: UIButton!
    let db = Firestore.firestore()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        ShowButton.rx.tap.subscribe(onNext: { [unowned self] in
            
            if let email = mailTextField.text,
               let password = passTextField.text{
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
                mailTextField.layer.borderColor = UIColor.black.cgColor
                passTextField.layer.borderColor = UIColor.black.cgColor
                
                
                SVProgressHUD.show()
                
                // ログイン
                Auth.auth().signIn(withEmail: email, password: password) { user, error in
                    if let error = error {
                        print(error)
                        SVProgressHUD.showError(withStatus: "Error!")
                        return
                    } else {
                        SVProgressHUD.showSuccess(withStatus: "Success!")
                        
                        if let user = Firebase.Auth.auth().currentUser{
                            let userID = user.uid
                            
                            self.db.collection("Users").document(userID).setData([
                                "LoginTime": nowTimeString()
                            ])
                            
                            let controller = StudyRoomViewController.instantiate()
                            self.present(controller, animated: true, completion: nil)
                            
                            SVProgressHUD.showSuccess(withStatus: "Success!")
                            
                        }
                    }
                }
            }
        }).disposed(by: disposeBag)
    }
}

