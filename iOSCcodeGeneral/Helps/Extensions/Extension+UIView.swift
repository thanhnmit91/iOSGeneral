//
//  Extension+UIView.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/16/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension UIView {
    func animationShowView(finish: ((Bool) -> Void)? = nil) {
        self.alpha = 0
        self.frame.origin.y = -self.frame.height
        UIView.animate(withDuration: 0.2, animations: {
            self.frame.origin.y = 0
            self.alpha = 1
        }, completion: finish)
    }
    
    func animationRemoveView(finish: ((Bool) -> Void)? = nil){
        UIView.animate(withDuration: 0.2, animations: {
            self.frame.origin.y = -self.frame.height
            self.alpha = 0
        }, completion: finish)
    }

    func setStyleView(){
        self.clipsToBounds = true
//        self.layer.backgroundColor = MainColors.colorBackgroundInput.cgColor
        self.layer.borderWidth = 1
//        self.layer.borderColor = MainColors.colorBackgroundInput.cgColor
        self.layer.cornerRadius = 6
        
    }
    
    func setStyleView(backgroundColor: UIColor? = nil, borderW: CGFloat? = nil, borderC: UIColor? = nil, cornerR: CGFloat? = nil){
        
        self.layer.backgroundColor = backgroundColor?.cgColor
        self.layer.borderWidth = borderW ?? 0
        self.layer.borderColor = borderC?.cgColor
        self.layer.cornerRadius = cornerR ?? 0
        
    }
    
    func gradientLayer(_ isBorder: Bool = true, radius: CGFloat = 30){
        self.layer.cornerRadius = isBorder ? radius : 0
        self.layer.masksToBounds = true
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.25, green: 0.261, blue: 0.8, alpha: 1).cgColor,
          UIColor(red: 0, green: 0.008, blue: 0.404, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer0.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width, height: self.bounds.size.height)
        self.layer.insertSublayer(layer0, at: 0)
    }
}
