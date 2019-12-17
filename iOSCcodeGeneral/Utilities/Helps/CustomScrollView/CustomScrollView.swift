//
//  CustomScrollView.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/16/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

class CustomScrollView: UIScrollView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGusture = UITapGestureRecognizer(target: self, action: #selector(actTap))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGusture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.superview!.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.contentInset = contentInset
    }
    
    @objc func actTap(){
        self.endEditing(true)
    }
    
}
