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

class ViewController: UIViewController{
    
    var db: Firestore!
    
    @IBOutlet weak var signInFacebookButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var termsOfServiceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



