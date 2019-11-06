//
//  ProfileViewController.swift
//  DatingApp
//
//  Created by Taku Funakoshi on 2019/11/02.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import SDWebImage


class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
//  Firebase Auth関連
  
    let user = Auth.auth().currentUser
    let userEmail = Auth.auth().currentUser?.email
    let userID = Auth.auth().currentUser?.uid
//  ローカルからの写真選択関連
    var imagePicker = UIImagePickerController()
//  Firebase firestore(DB)関連
    let db = Firestore.firestore()
//  Firebase Storage関連
    

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var changeAvatarLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var upload: UIButton!
    @IBOutlet weak var yourName: UILabel!
    @IBOutlet weak var yourNameText: UITextField!
    @IBOutlet weak var yourGender: UILabel!
    @IBOutlet weak var yourGenderSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
            super.viewDidLoad()
         Auth.auth().addStateDidChangeListener { (auth, user) in
        
          if((user) != nil){
            
          }else{
            print("Profile : Not Logged in")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let top = storyboard.instantiateViewController(withIdentifier: "top") as! ViewController
            self.view.window?.rootViewController = top
          }
        }
        self.title = "設定"
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.leftBarButtonItem?.title = "LogOut"
        reset()
        showEmail()
        setImage(userId: userID!, imageView: avatar)
    }
    
    
    
//    アバタータッチしたらアルバムから写真選択
    @IBAction func avatarTapButton(_ sender: Any) {
        let album = UIImagePickerController.SourceType.savedPhotosAlbum
            
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker = UIImagePickerController()
            picker.sourceType = album
            picker.delegate = self
            self.present(picker,animated: true)
        }
    }
//   uploadボタン廃止して自動保存にした。このメソッド使ってるのでそのまま。
    @IBAction func uploadButtonTapped(_ sender: Any) {
        
        print(userID!)
        let uploadRef = Storage.storage().reference().child("avatar").child(userID!)
        guard let imageData = avatar.image?.jpegData(compressionQuality: 1.0) else {return}
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpg"
        
//        firebase storageに送る処理
        let taskRefernce = uploadRef.putData(imageData, metadata: uploadMetadata) { metadata, error in
                if let error = error{
                    print("error \(error.localizedDescription)")
                    return
                }
                    print("I got this back \(String(describing: metadata))")
            }
//        送る処理の経過観察とプログレスバー表示
        taskRefernce.observe(.progress){[weak self](SnapshotMetadata) in
            self?.progress.isHidden = false
            guard let pctThere = SnapshotMetadata.progress?.fractionCompleted else{return}
            self?.progress.progress = Float(pctThere)
            if pctThere == 1{
                UIProgressView.animate(withDuration: 2.0, animations: {self?.progress.alpha = 0.0}) { (isCompleted) in
                    self?.progress.isHidden = true
                    }
                }
        }
    }
//    写真選択終わったら発動
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.avatar.image = image
        self.dismiss(animated:true)
        uploadButtonTapped(AnyClass.self)
        reset()
        setBarButton()
    }

//   プログレスバーはリセットしないと２回目映らない。
    func reset() {
        progress.progress = 0.0
        progress.isHidden = true
        self.progress.alpha = 1
    }
    
//    いつものキーボード閉じるやつ
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
//    アバターの上にemail表示。できれば名前に変更
    func showEmail(){
        guard let email = userEmail else{return}
        self.userEmailLabel.text = "Hi! \(email)"
    }

    
    func setImage(userId: String, imageView: UIImageView?){
        let storageRef = Storage.storage().reference().child("avatar/\(userId)")
        
        storageRef.downloadURL { url, error in
          guard let url = url
            else {
                print("There are no image on Fire Storage")
                return
            }
          imageView?.sd_setImage(with: url, placeholderImage: nil)
          self.setBarButton()
          
        }
    }
    
    //    Kolodaビューへ遷移　？？なぜobjc付くか不明
    @objc func presentKoloda() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let koloda = storyboard.instantiateViewController(withIdentifier: "koloda") as! MyKolodaViewController
        self.navigationController?.pushViewController(koloda, animated: true)
    }
    
    @objc func presentSignUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUp = storyboard.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
        self.present(signUp, animated: true, completion: nil)
    }
    
    func setBarButton(){
        let rightBarButton = UIBarButtonItem(
            title: "Go Tinder",
            style: .plain,
            target: self,
            action: #selector(presentKoloda)
        )
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem(
            title: "ログアウト",
            style: .plain,
            target: self,
            action: #selector(logOut)
        )
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func logOut(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let top = storyboard.instantiateViewController(withIdentifier: "top") as! ViewController
            self.view.window?.rootViewController = top

        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    
        
        
}







////            let uploadTask = uploadRef.putf
////              guard let metadata = metadata else {
////                // Uh-oh, an error occurred!
////                print("Can not get metadata downloaded")
////                return
////              }
////              // Metadata contains file metadata such as size, content-type.
////                _ = metadata.size
////              // You can also access to download URL after upload.
////              uploadRef.downloadURL { (url, error) in
////                guard url != nil else {
////                  // Uh-oh, an error occurred!
////                    print("Can not get downloadURL")
////                  return
////                }
////              }
////            }
//        }
//
//
//

