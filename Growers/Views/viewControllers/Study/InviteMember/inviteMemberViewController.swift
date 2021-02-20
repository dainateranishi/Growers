

import Foundation
import UIKit
import PencilKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class InviteMemberController: UIViewController{

    @IBOutlet weak var friendTableView: UITableView!
    @IBOutlet weak var inviteAllMemberButton: UIButton!
    @IBOutlet weak var invitePostButton: UIButton!
    @IBOutlet weak var homeButton: UIView!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var commenttextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
