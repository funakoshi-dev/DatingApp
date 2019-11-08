
import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import SDWebImage

class TinderViewController: UIViewController {
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    struct userData {
        var UID: String
        var YRNAME: String
        var HAIR: String
        var DLURL: String
    }
    private var datas : [userData] = []
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataRef = db.collection("users")
        dataRef.order(by: "HAIR")
        print("dataRef = \(dataRef)")
        dataRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    //▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼追加▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
    //-------------------------------------
    // ユーザ取得
    //-------------------------------------
    func fetchUser(){
        //-------------------------------------
        // 現在地に近いユーザ検索
        //-------------------------------------
        // ログインユーザの現在地取得
//        let currentGeoPoint = NCMBUser.current().object(forKey: "geopoint") as! NCMBGeoPoint
        // 探している性別
//        let interestedInWomen = NCMBUser.current().object(forKey: "interestedInWomen") as! Bool
        // クエリ作成
//        let query = NCMBQuery(className: "user")
//        let data = Firestore.firestore().collection("users").order(by: "HAIR")
//        if let snapshot =
//        query?.whereKey("geopoint", nearGeoPoint:currentGeoPoint, withinKilometers: 1.0)
//        // 探している性別に合わせ検索条件変更
//        if interestedInWomen == true {
//            query?.whereKey("gender", equalTo: "female")
//        } else {
//            query?.whereKey("gender", equalTo: "male")
//        }
        // 取得件数は1件
//        query?.limit = 1
//        query?.findObjectsInBackground({(objects, error) in
//            if (error != nil){
//                print("友達取得失敗:\(error)")
//            } else {
//                print("友達取得成功:\(objects)")
//                if (objects?.count)! > 0 {
//                    self.displayedUser = objects?[0] as! NCMBUser
//                    // ユーザプロフィール画像表示
//                    let fbPictureUrl = "https://www.image-pit.com/img/rainbowapps-swift3/deai/" + (objects?[0] as AnyObject).userName + ".png"
//                    // 本番環境は下記
//                    // let fbPictureUrl = "https://graph.facebook.com/" + objects[0].userName + "/picture?type=large"
//                    if let fbpicUrl = NSURL(string: fbPictureUrl) {
//                        if let data = NSData(contentsOf: fbpicUrl as URL) {
//                            self.userImageView.image = UIImage(data: data as Data)
//                        }
//                    }
//                } else {
//                    // 画像を初期化して非表示
//                    self.userImageView.image = UIImage()
//                    self.userImageView.isUserInteractionEnabled = false
//                }
//            }
//        })
    }
    //▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲追加▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
   
}
