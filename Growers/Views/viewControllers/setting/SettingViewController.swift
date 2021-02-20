//
//  Home.swift
//  Growers
//
//  Created by 寺西帝乃 on 2021/02/19.
//

import Foundation
import UIKit
import PencilKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class SettingViewController: UIViewController{
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var friendtableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    class func instantiate() -> SettingViewController {
        let controller = UIStoryboard(name: "Setting", bundle: .main).instantiateInitialViewController() as! SettingViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
