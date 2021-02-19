//
//  AnswerViewController.swift
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

class AnswerViewController: UIViewController{
    @IBOutlet weak var usericon: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var NoteView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var noteButton: UIView!
    @IBOutlet weak var settingButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
