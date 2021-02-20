import UIKit
import PencilKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

class StudyRoomViewController: UIViewController, PKToolPickerObserver, PKCanvasViewDelegate, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, UIScrollViewDelegate {
    
    //    @IBOutlet weak var AddPageButton: UIButton!
    @IBOutlet weak var MemberView: UIView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var MenuView: UIView!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var ToolBer: PencilCaseView!
    @IBOutlet weak var AddPageButton: UIButton!
    @IBOutlet weak var ContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var MemberTable: UITableView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    private var disposeBag = DisposeBag()
    private var CanvasHeight: CGFloat?
    private var CanvasWidht: CGFloat?
    let db = Firestore.firestore()
    var UserName: String?
    var PagenNum = 1
    var MemList:[Member] = [Member]()
    
//    class func instantiate() -> StudyRoomViewController {
//        let controller = UIStoryboard(name: "studyRoom", bundle: .main).instantiateInitialViewController() as! StudyRoomViewController
//        return controller
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        if let user = user {
            self.UserName = user.displayName
        }
        
        MemberTable.dataSource = self
        MemberTable.delegate = self
        MemberTable.register(UINib(nibName: "MemberIconCell", bundle: nil), forCellReuseIdentifier: "MemberIconCell")
        self.setupMember()
        
        ScrollView.delegate = self
        CanvasHeight = ContentView.frame.size.height
        CanvasWidht = ContentView.frame.size.width
        self.setupNote()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //Memberから削除
        self.db.collection("StudyRoom").document(self.UserName!).delete(){err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        //Noteの保存
        self.ContentView.subviews.forEach({note in
            if note is Canvas{
                print(type(of: note))
                (note as! Canvas).savePage()
            }
        })
    }
    
    
    //MemberTable setup
    func setupMember(){
        self.db.collection("StudyRoom").addSnapshotListener({querySnapshot, err in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(err!)")
                return
            }
            snapshot.documentChanges.forEach{diff in
                if diff.type == .added{
                    if self.UserName != diff.document.documentID{
                        self.MemList.append(Member(name: diff.document.documentID))
                        self.MemberTable.reloadData()
                    }
                }
                if diff.type == .removed{
                    self.MemList.forEach({mem in
                        if mem.name == diff.document.documentID{
                            self.MemList.remove(at: self.MemList.firstIndex(of: mem)!)
                            self.MemberTable.reloadData()
                        }
                    })
                }
            }
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberIconCell", for: indexPath ) as! MemberIconCellTableViewCell
        cell.setup(mem: MemList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MemberIconCellTableViewCell else {
            return
        }
        
        let shareWindowController = ShareWindowController.instantiate(name: cell.Membername.text!)
        shareWindowController.modalPresentationStyle = .popover
        let shareWindowSize = CGSize(width: self.CanvasWidht!/2, height: self.CanvasHeight!/2)
        shareWindowController.preferredContentSize = shareWindowSize
        
        let presentationController = shareWindowController.popoverPresentationController
        presentationController?.delegate = self
        presentationController?.permittedArrowDirections = .up
        presentationController?.sourceView = cell
        presentationController?.sourceRect = cell.frame
        presentationController?.permittedArrowDirections = .left
        
        present(shareWindowController, animated: true, completion: nil)
        shareWindowController.shrinkFrame(frameSize: shareWindowSize)
    }
    
    
    @IBAction func TapAddPage(_ sender: Any) {
        expandContentSize(drawingData: nil)
        PagenNum += 1
        print(PagenNum)
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
        ContentViewHeight.constant = contentsHeight
        addCanvas(page: PagenNum, drawingData: drawingData)
        
    }
    
    func addCanvas(page : Int, drawingData: Data?){
        let newCanvas = Canvas()
        newCanvas.setup(page: self.PagenNum, name: self.UserName!, drawingData: drawingData)
        newCanvas.translatesAutoresizingMaskIntoConstraints = false
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
        updateScrollInset()
        
        ToolBer.registerCanvas(Canvas: newCanvas.CanvasView)
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
        
        print(self.ScrollView.zoomScale)
        print(self.ContentView.center)
        
        self.db.collection(UserName!).document("Zoom").setData([
            "zoomScale": self.ScrollView.zoomScale,
            "ContentViewCenter": NSCoder.string(for: self.ContentView.center)
        ])
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        self.db.collection(UserName!).document("Scroll").setData([
            "scroll": NSCoder.string(for: contentOffset)
        ])
    }
    
}

