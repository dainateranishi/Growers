//
//  ShareWindow.swift
//  Note
//
//  Created by 寺西帝乃 on 2021/02/08.
//

import Foundation
import UIKit
import PencilKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class ShareWindowController: UIViewController, PKToolPickerObserver, PKCanvasViewDelegate, UIScrollViewDelegate{
    @IBOutlet var WindowView: UIView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var ContentViewHeight: NSLayoutConstraint!
    private var CanvasHeight: CGFloat?
    private var CanvasWidht: CGFloat?
    let db = Firestore.firestore()
    var UserName: String?
    var PagenNum = 1
    
    class func instantiate(name: String) -> ShareWindowController {
        let controller = UIStoryboard(name: "ShareWindow", bundle: .main).instantiateInitialViewController() as! ShareWindowController
        controller.UserName = name
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CanvasHeight = ContentView.frame.size.height
        CanvasWidht = ContentView.frame.size.width
        self.setupNote()
        ScrollView.delegate = self
        scrollObserver()
        zoomObserver()
    }
    
    func zoomObserver(){
        self.db.collection(UserName!).document("Zoom").addSnapshotListener{ documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Zoom Document data was empty.")
                return
            }
            if let zoomScale = data["zoomScale"] as? CGFloat, let contentViewCenter = data["ContentViewCenter"] as? String{
                self.autoZoom(zoomScale: zoomScale, contentViewCenter: NSCoder.cgPoint(for: contentViewCenter))
            }
            
        }
    }
    
    func scrollObserver(){
        self.db.collection(UserName!).document("Scroll").addSnapshotListener{ documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            if let scrollOffset = data["scroll"] as? String{
                let offset = NSCoder.cgPoint(for: scrollOffset)
                self.ScrollView.contentOffset = offset
                
            }
        }
        
    }
    
    // Note function
    
    func setupNote(){
        self.db.collection(self.UserName!).getDocuments(){(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.expandContentSize(drawingData: nil)
            } else {
                if querySnapshot!.documents.isEmpty {
                    self.expandContentSize(drawingData: nil)
                    self.PagenNum += 1
                }else{
                    for document in querySnapshot!.documents {
                        let drawingData = document.get("drawing")
                        self.expandContentSize(drawingData: drawingData as? Data)
                        self.PagenNum += 1
                    }
                }
            }
        }
    }
    
    
    func expandContentSize(drawingData: Data?){
        let contentsHeight = CanvasHeight!  * CGFloat(PagenNum)
        //        ContentView.frame.size.height = contentsHeight
        ContentViewHeight.constant = contentsHeight
        addCanvas(page: PagenNum, drawingData: drawingData)
        
    }
    
    func addCanvas(page : Int, drawingData: Data?){
        let newCanvas = Canvas()
        newCanvas.setup(page: self.PagenNum, name: self.UserName!, drawingData: drawingData)
        newCanvas.translatesAutoresizingMaskIntoConstraints = false
        newCanvas.unenableDrawing()
        //add newCanvas to ContentView
        ContentView.addSubview(newCanvas)
        //Constrains for new canvas
        NSLayoutConstraint.activate([
            newCanvas.widthAnchor.constraint(equalToConstant: CanvasWidht!),
            newCanvas.heightAnchor.constraint(equalToConstant: CanvasHeight!),
            newCanvas.centerXAnchor.constraint(equalTo: ContentView.centerXAnchor),
            newCanvas.topAnchor.constraint(equalTo: ContentView.topAnchor, constant: CanvasHeight! * CGFloat(PagenNum - 1)),
        ])
        
        ContentView.setNeedsLayout()
        ContentView.layoutIfNeeded()
    }
    
    func shrinkFrame(frameSize: CGSize){
        self.WindowView.transform = self.ContentView.transform.scaledBy(x: frameSize.width/ContentView.frame.width, y: frameSize.height/ContentView.frame.height);
    }
    
    // Zooming
    func viewForZooming(in: UIScrollView) -> UIView? {
        // ズームのために要指定
        return ContentView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // ズームのタイミングでcontentInsetを更新
        updateScrollInset()
    }
    
    private func updateScrollInset() {
        // imageViewの大きさからcontentInsetを再計算
        // なお、0を下回らないようにする
        let zoomHeight = (ScrollView.frame.height - ContentView.frame.height)/2
        let zoomWidth = (ScrollView.frame.width - ContentView.frame.width)/2
        
        ScrollView.contentInset = UIEdgeInsets(
            top: max(zoomHeight, 0),
            left: max(zoomWidth, 0),
            bottom: 0,
            right: 0
        );
    }
    
    private func autoZoom(zoomScale: CGFloat, contentViewCenter: CGPoint){
        let rect = zoomRect(for: self.ScrollView, scale: zoomScale, center: contentViewCenter)
        self.ScrollView.zoom(to: rect, animated: true)
    }
    
    private func zoomRect(for scrollView: UIScrollView, scale: CGFloat, center: CGPoint) -> CGRect {
        let size = CGSize(
            width: scrollView.frame.width / scale,
            height: scrollView.frame.height / scale
        )
        let rect = CGRect(
            origin: CGPoint(
                x: center.x - size.width / 2.0,
                y: center.y - size.height / 2.0
            ),
            size: size
        )
        return rect
    }
    
}
