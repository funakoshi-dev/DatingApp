//
//  MyKolodaViewController.swift
//  DatingApp
//
//  Created by Taku Funakoshi on 2019/10/31.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import UIKit
import Koloda
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class MyKolodaViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    var imageNameArray = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg", ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButton()
        self.title = "Tinder"
        self.view.backgroundColor = UIColor.systemPink

        kolodaView.dataSource = self
        kolodaView.delegate = self
        kolodaView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        kolodaView.center = self.view.center
        self.view.reloadInputViews()
    }
}

//MARK:- KolodaViewDataSource
extension MyKolodaViewController: KolodaViewDataSource {
    
    public func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return imageNameArray.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
//        // Card.
        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 2
        
        
        // Add a label.
//        let label = UILabel()
//        label.text = items[index]
//        label.sizeToFit()
//        label.center = view.center
//        view.addSubview(label)
        let color = generateRandomColor()
        let imageView = UIImageView(frame: koloda.bounds)
//        imageView.layer.shadowColor = UIColor.black.cgColor
//        imageView.layer.shadowOpacity = 0.6
//        imageView.layer.shadowOffset = CGSize(width: 1, height: 1.5)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: URL(string:"https://firebasestorage.googleapis.com/v0/b/auth-fa967.appspot.com/o/avatar%2FvX28mbRCkET32CRVnHddReErdDj1?alt=media&token=eff1a682-7fd8-49e7-bd12-29457e32ebd5"), placeholderImage: UIImage(named: "taq"))
//        koloda.addSubview(imageView)
        imageView.backgroundColor = color
        return imageView
        
        
    }
}

//MARK:- KolodaViewDelegate
extension MyKolodaViewController: KolodaViewDelegate {
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right]
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("Finish cards.")
        //シャッフル
        imageNameArray = imageNameArray.shuffled()
        //リスタート
        koloda.resetCurrentCardIndex()
    }
    
    func generateRandomColor() -> UIColor {
      let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
      let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
      let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
            
      return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    @objc func presentProfile() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    
    func setBarButton(){
        let rightBarButton = UIBarButtonItem(
            title: "chat",
            style: .plain,
            target: self,
            action: nil
        )
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem(
            title: "設定",
            style: .plain,
            target: self,
            action: #selector(presentProfile)
        )
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
//    func setImage(userId: String, imageView: UIImageView?){
//        let storageRef = Storage.storage().reference().child("avatar/\(userId)")
//
//        storageRef.downloadURL { url, error in
//          guard let url = url
//            else {
//                print("There are no image on Fire Storage")
//                return
//            }
//          imageView?.sd_setImage(with: url, placeholderImage: nil)
//          let urlString = NSURL(
//            imageNameArray.append(urlString)
//
//        }
//    }
}


