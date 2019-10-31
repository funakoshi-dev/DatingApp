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
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullnameContainterView: UIView!
    @IBOutlet weak var fullnameTextField: UITextField!
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
    
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
                self.presentTinder()
            }
        }
    }
    
    func emailSignIn (email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let _error = error {
                self.signInErrAlert(_error)
            } else {
                print("SignIn success")
                self.presentTinder()
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
    
    func presentTinder() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tinder = storyboard.instantiateViewController(withIdentifier: "tinder")
        self.present(tinder, animated: true, completion: nil)
    }
    
}
