

import Foundation
import UIKit
import PencilKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class PostQuestionViewController: UIViewController{
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var NoteView: UIView!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
