import UIKit
import PencilKit
 
class PencilCaseView: UIView {
    var pKCanvasView: PKCanvasView? = nil
    var CanvasViews: [PKCanvasView] = []
 
    let pencilInteraction = UIPencilInteraction()
     
    enum Ink {
        case black
        case red
        case blue
        case green
        case orange
        case purple
        case brown
        case yellow
    }
 
    var selectInk: Ink = .black
    var saveInk: Ink = .black
    var onPencil = false
    var onMarker = false
    var onErase = false
 
    @IBOutlet weak var inkBlack: UIButton!
    @IBOutlet weak var inkRed: UIButton!
    @IBOutlet weak var inkBlue: UIButton!
    @IBOutlet weak var inkGreen: UIButton!
    @IBOutlet weak var inkOrange: UIButton!
    @IBOutlet weak var inkPurple: UIButton!
    @IBOutlet weak var inkBrown: UIButton!
    @IBOutlet weak var inkYellow: UIButton!
    @IBOutlet weak var inkErase: UIButton!
    @IBOutlet weak var pencil: UIButton!
    @IBOutlet weak var marker: UIButton!
    @IBOutlet weak var ruler: UIButton!
     
    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }
 
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
     
    convenience init(frame: CGRect, pKCanvasView: PKCanvasView) {
        self.init(frame: frame)
        self.pKCanvasView = pKCanvasView
        self.pKCanvasView!.tool = PKInkingTool(.pen, color: .black, width: PKInkingTool.InkType.pen.defaultWidth)
        self.inkBlack.backgroundColor = .systemGray5
    }
 
    func loadNib(){
        let view = Bundle.main.loadNibNamed("PencilCaseView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        self.pencilInteraction.delegate = self
        view.addInteraction(self.pencilInteraction)
    }
    
    func registerCanvas(Canvas: PKCanvasView){
        CanvasViews.append(Canvas)
        updateInk(ink: self.selectInk)
    }
     
    func inkBackground(ink: Ink) {
        self.inkBlack.backgroundColor = .clear
        self.inkRed.backgroundColor = .clear
        self.inkBlue.backgroundColor = .clear
        self.inkGreen.backgroundColor = .clear
        self.inkOrange.backgroundColor = .clear
        self.inkPurple.backgroundColor = .clear
        self.inkBrown.backgroundColor = .clear
        self.inkYellow.backgroundColor = .clear
        self.inkErase.backgroundColor = .clear
        switch ink {
        case .black:
            self.inkBlack.backgroundColor = .systemGray5
        case .red:
            self.inkRed.backgroundColor = .systemGray5
        case .blue:
            self.inkBlue.backgroundColor = .systemGray5
        case .green:
            self.inkGreen.backgroundColor = .systemGray5
        case .orange:
            self.inkOrange.backgroundColor = .systemGray5
        case .purple:
            self.inkPurple.backgroundColor = .systemGray5
        case .brown:
            self.inkBrown.backgroundColor = .systemGray5
        case .yellow:
            self.inkYellow.backgroundColor = .systemGray5
        }
    }
     
    @IBAction func tapBlack(_ sender: Any) {
        self.onErase = false
        self.inkBackground(ink: .black)
        self.updateInk(ink: .black)
    }
     
    @IBAction func tapRed(_ sender: Any) {
        self.onErase = false
        self.inkBackground(ink: .red)
        self.updateInk(ink: .red)
    }
     
    @IBAction func tapBlue(_ sender: Any) {
        self.onErase = false
        self.inkBackground(ink: .blue)
        self.updateInk(ink: .blue)
    }
     
    @IBAction func tapGreen(_ sender: Any) {
        self.onErase = false
        self.inkBackground(ink: .green)
        self.updateInk(ink: .green)
    }
     
    @IBAction func tapOrange(_ sender: Any) {
        self.onErase = false
        self.inkBackground(ink: .orange)
        self.updateInk(ink: .orange)
    }
     
    @IBAction func tapPurple(_ sender: Any) {
        self.onErase = false
        self.inkBackground(ink: .purple)
        self.updateInk(ink: .purple)
    }
     
    @IBAction func tapBrown(_ sender: Any) {
        self.onErase = false
        self.inkBackground(ink: .brown)
        self.updateInk(ink: .brown)
    }
     
    @IBAction func tapYellow(_ sender: Any) {
        self.onErase = false
        self.inkBackground(ink: .yellow)
        self.updateInk(ink: .yellow)
    }
     
    @IBAction func tapErase(_ sender: Any) {
        self.onErase.toggle()
        let color: UIColor = self.onErase ? .blue : .black
        self.inkErase.tintColor = color
        self.updateInk()
    }
 
    @IBAction func tapPencil(_ sender: Any) {
        self.onErase = false
        self.onPencil.toggle()
        if self.onMarker == true {
            self.onMarker = false
            self.marker.tintColor = .black
        }
        let color: UIColor = self.onPencil ? .blue : .black
        self.pencil.tintColor = color
        self.updateInk()
    }
     
    @IBAction func tapMarker(_ sender: Any) {
        self.onMarker.toggle()
        self.onErase = false
        if self.onPencil == true {
            self.onPencil = false
            self.pencil.tintColor = .black
        }
        let color: UIColor = self.onMarker ? .blue : .black
        self.marker.tintColor = color
        self.updateInk()
    }
     
    @IBAction func tapRuler(_ sender: Any) {
        self.CanvasViews.forEach({canvas in
            canvas.isRulerActive.toggle()
//            let color: UIColor = canvas.isRulerActive ? .blue : .black
        })
//        self.pKCanvasView?.isRulerActive.toggle()
        let color: UIColor = self.CanvasViews.first!.isRulerActive ? .blue : .black
        self.ruler.tintColor = color
    }
     
    func updateInk(ink: Ink? = nil) {
        if let ink = ink {
            self.saveInk = self.selectInk
            self.selectInk = ink
        }
        if self.onErase == true {
//            self.pKCanvasView!.tool = PKEraserTool(.vector)
            self.CanvasViews.forEach({canvas in
                canvas.tool = PKEraserTool(.vector)
            })
        }
        else if self.onPencil == true {
            self.CanvasViews.forEach({canvas in
                canvas.tool = PKInkingTool(.pencil, color: selectInkToUIColor(), width: PKInkingTool.InkType.pencil.defaultWidth)
            })
        }
        else if self.onMarker == true {
            self.CanvasViews.forEach({canvas in
                canvas.tool = PKInkingTool(.marker, color: selectInkToUIColor(), width: PKInkingTool.InkType.marker.defaultWidth)
            })
        }
        else {
            self.CanvasViews.forEach({canvas in
                canvas.tool = PKInkingTool(.pen, color: selectInkToUIColor(), width: PKInkingTool.InkType.pen.defaultWidth)
            })
        }
    }
     
    func selectInkToUIColor() -> UIColor {
        var result: UIColor = .clear
        switch selectInk {
        case .black:
            result = .black
        case .red:
            result = .red
        case .blue:
            result = .blue
        case .green:
            result = .green
        case .orange:
            result = .orange
        case .purple:
            result = .purple
        case .brown:
            result = .brown
        case .yellow:
            result = .yellow
       }
        return result
    }
}
 
extension PencilCaseView: UIPencilInteractionDelegate {
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        self.onErase.toggle()
        let color: UIColor = self.onErase ? .blue : .black
        self.inkErase.tintColor = color
        self.updateInk()
    }
}

