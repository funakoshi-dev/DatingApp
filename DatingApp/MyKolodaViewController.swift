//
//  MyKolodaViewController.swift
//  DatingApp
//
//  Created by Taku Funakoshi on 2019/10/31.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import UIKit
import Koloda

class MyKolodaViewController: UIViewController {
    
    let items = [ "Red", "Green", "Blue", "Black", "White", "Orange", "Mageda", "Yellow", "Gray" ]
    
    @IBOutlet weak var kolodaView: KolodaView!
    var imageNameArray = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg", ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TinderUI Sample"
        self.view.backgroundColor = UIColor.white

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
        return items.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        // Card.
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.layer.backgroundColor = UIColor.systemPink.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        
        // Add a label.
        let label = UILabel()
        label.text = items[index]
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)
        
        return view
    }
}

//MARK:- KolodaViewDelegate
extension MyKolodaViewController: KolodaViewDelegate {
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right, .up]
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("Finish cards.")
    }
}

