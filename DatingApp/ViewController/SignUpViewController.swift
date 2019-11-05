//
//  SignUpViewController.swift
//  DatingApp
//
//  Created by Taku Funakoshi on 2019/10/30.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var emailContainterView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordContainterView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else{return}
        if email.isEmpty{
            self.singleAlert(title:"Error", message: "Enter you email address")
            return
        }
        
        if password.isEmpty{
            self.singleAlert(title:"Error", message: "Enter you password")
            return
        }
        self.emailSignUp(email: email, password: password)
    }
    
    @IBAction func signinButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else{return}
        if email.isEmpty{
            self.singleAlert(title:"Error", message: "Enter you email address")
            return
        }
        
        if password.isEmpty{
            self.singleAlert(title:"Error", message: "Enter you password")
            return
        }
        self.emailSignIn(email: email, password: password)
    }
    
    func emailSignUp (email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let _error = error {
                self.signUpErrAlert(_error)
            } else {
                print("SignUp success")
                self.presentAfterLogin()
            }
        }
    }
    
    func emailSignIn (email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let _error = error {
                self.signInErrAlert(_error)
            } else {
                print("SignIn success")
                self.presentAfterLogin()
            }
        }
    }
    
    func signUpErrAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
            case .invalidEmail:      message =  "有効なメールアドレスを入力してください"
            case .emailAlreadyInUse: message = "既に登録されているメールアドレスです"
            case .weakPassword:      message = "パスワードは６文字以上で入力してください"
            default:                 message = "エラー: \(error.localizedDescription)"
            }
            self.singleAlert(title: "登録できません", message: message)
        }
    }
    
    func signInErrAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
            case .userNotFound:  message = "アカウントが見つかりませんでした"
            case .wrongPassword: message = "パスワードを確認してください"
            case .userDisabled:  message = "アカウントが無効になっています"
            case .invalidEmail:  message = "Eメールが無効な形式です"
            default:             message = "エラー: \(error.localizedDescription)"
            }
            self.singleAlert(title: "ログインできません", message: message)
        }
    }
    
    func presentAfterLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
//    // ②遷移先ViewControllerのインスタンス取得
//           let nextView = storyboard.instantiateViewController(withIdentifier: "view2") as! View2ViewController
//
//           // ③画面遷移
//           self.present(nextView, animated: true, completion: nil)
//    // ③画面遷移（Navigation Controller管理下の場合）
//    self.navigationController?.pushViewController(nextView, animated: true)
//       }
}
