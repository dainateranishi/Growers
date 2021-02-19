//
//  commentViewConttroller.swift
//  Growers
//
//  Created by 寺西帝乃 on 2021/02/20.
//

import Foundation
import UIKit
import PencilKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class CommentViewController: UIViewController{

    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
