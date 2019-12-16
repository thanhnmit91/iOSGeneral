//
//  AlertViewController.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/16/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

class AlertsViewController: UIViewController {

    @IBOutlet var panView: UIPanGestureRecognizer!
    @IBOutlet weak var viewContains: UIView!
//    @IBOutlet weak var lbTitle: BaseUILabel!
//    @IBOutlet weak var lbDetail: BaseUILabel!
    
    var titleText: String = ""
    var detailText: String = ""
    
    init(title: String, detail: String) {
        self.titleText = title
        self.detailText = detail
        super.init(nibName: AlertsViewController.description().components(separatedBy: ".").last!, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.viewContains.animationShowView { [weak self](_) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self?.removeSelf()
//            }
//        }
        self.view.backgroundColor = .clear
//        lbTitle.text = titleText
//        lbDetail.text = detailText
//        lbTitle.textColor = .white
//        lbDetail.textColor = .white
    }
    
    override func viewDidLayoutSubviews() {
//        viewContains.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
    }
    
    func updateUI(_ txtTitle: String = "Notify", txtDetail: String) {
//        lbTitle.text = txtTitle
//        lbDetail.text = txtDetail
    }

    @IBAction func panMove(_ sender: UIPanGestureRecognizer) {
        let movePosition = sender.velocity(in: self.viewContains)
        if movePosition.y < 0 {
            removeSelf()
        }
    }
    
    func removeSelf() {
//        self.viewContains.animationRemoveView { [weak self] (_) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                //self?.willMove(toParent: nil)
//                self?.view.removeFromSuperview()
//                self?.removeFromParent()
//            }
//        }
    }
    

}
