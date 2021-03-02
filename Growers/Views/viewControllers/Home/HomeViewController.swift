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

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var SegueButtonView: UIView!
    
    class func instantiate() -> HomeViewController {
        let controller = UIStoryboard(name: "home", bundle: .main).instantiateInitialViewController() as! HomeViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
