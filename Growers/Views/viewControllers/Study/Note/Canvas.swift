//
//  Canvas.swift
//  PencilKitSample
//
//  Created by 寺西帝乃 on 2021/02/03.
//

import UIKit
import PencilKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class Canvas: UIView, PKToolPickerObserver, PKCanvasViewDelegate {
    
    
    @IBOutlet weak var CanvasView: PKCanvasView!
    @IBOutlet weak var BottomLabel: UILabel!
    @IBOutlet weak var PageLabel: UILabel!
    let db = Firestore.firestore()
    var UserName: String?
    
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureView()
    }
    
    private func configureView(){
        loadNib()
    }
    
    func loadNib(){
        let view = Bundle.main.loadNibNamed("Canvas", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func setup(page: Int, name: String, drawingData: Data?){
        self.CanvasView.delegate = self
        PageLabel.text = "Page" + String(page)
        self.UserName = name
        if let drawingData = drawingData, let drawing = try? PKDrawing(data: drawingData){
            self.CanvasView.drawing = drawing
        }
    }
    
    func savePage(){
        let drawingData = self.CanvasView.drawing.dataRepresentation()
        self.db.collection(self.UserName!).document(PageLabel.text!).setData([
            "drawing": drawingData
        ])
    }
    
    func unenableDrawing(){
        CanvasView.drawingGestureRecognizer.isEnabled = false
        self.db.collection(self.UserName!).document(PageLabel.text!).addSnapshotListener{ documentSnapshot, error in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard let data = document.data() else {
              print("Document data was empty.")
              return
            }
            if let drawingData = data["drawing"] as? Data, let drawing = try? PKDrawing(data: drawingData){
                self.CanvasView.drawing = drawing
            }
          }
    }
    
    // MARK: PKCanvasViewDelegate
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print("canvasViewDidBeginUsingTool")
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print("canvasViewDidEndUsingTool")
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print("canvasViewDrawingDidChange")
        self.savePage()
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print("canvasViewDidFinishRendering")
    }
    
    
}
