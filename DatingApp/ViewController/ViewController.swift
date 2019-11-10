
import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth

class ViewController: UIViewController{
    
    var window: UIWindow?
    var db: Firestore!
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var termsOfServiceLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AuthManager().isLogin() {
            self.presentKoloda()
        } else {}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func goNextTapped(_ sender: Any) {
        presentSignUp()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("🌞")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("👿")
    }
    
    
   @objc func presentKoloda() {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let koloda = storyboard.instantiateViewController(withIdentifier: "koloda") as! MyKolodaViewController
       self.navigationController?.pushViewController(koloda, animated: true)
   }
   
   @objc func presentSignUp() {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let signup = storyboard.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
       self.navigationController?.pushViewController(signup, animated: true)
    }
    
}
    









