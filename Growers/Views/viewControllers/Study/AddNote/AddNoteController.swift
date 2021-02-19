//
//  AddNoteController.swift
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

class AddNoteController: UIViewController{
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var noteNameTextField: UITextField!
    @IBOutlet weak var addNoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
