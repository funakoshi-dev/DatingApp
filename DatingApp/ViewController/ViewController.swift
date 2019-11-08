//
//  ViewController.swift
//  DatingApp
//
//  Created by Taku Funakoshi on 2019/10/30.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore
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
        Auth.auth().addStateDidChangeListener { (auth, user) in
        
          if((user) != nil){
            print("vc to koloda")
            self.presentKoloda()
//            let vc = self.storyboard?.instantiateViewController(identifier: "koloda") as! MyKolodaViewController
//            self.navigationController?.pushViewController(vc, animated: false)
//            //            以下を使うとNavigationViewにならないのでボツ
//            //            self.view.window?.rootViewController = vc
          }else{
//              self.view.window?.rootViewController = self
            print("Not Logged in")
          }
        }
    }
//    //▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼追加▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        ncmbLoginCheck()
//    }
//    // NCMBログインチェック
//    func ncmbLoginCheck(){
//        if (Auth.auth().currentUser?.uid != nil) {
//            print("ログイン済み")
//            presentKoloda()
//
//        } else {
//            print("未ログイン")
//        }
//    }
    //▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲追加▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
    
    
    @IBAction func goNextButton(_ sender: Any) {
        presentSignUp()
    }
    
    @objc func presentSignUp() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let signUp = storyboard.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
           self.present(signUp, animated: true, completion: nil)
    }
    
    @objc func presentKoloda() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let koloda = storyboard.instantiateViewController(withIdentifier: "koloda") as! MyKolodaViewController
           self.navigationController?.pushViewController(koloda, animated: true)
    }
    
    
}
    









