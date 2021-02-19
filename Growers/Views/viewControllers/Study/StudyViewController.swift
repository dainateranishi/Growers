//
//  Study.swift
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


class StudyViewController: UIViewController{
    
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var notesViewCollection: UICollectionView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    class func instantiate() -> StudyViewController {
        let controller = UIStoryboard(name: "Stidy", bundle: .main).instantiateInitialViewController() as! StudyViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
