//
//  BaseViewController.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var tapDismiss: UITapGestureRecognizer!
    
    deinit {
        print("\(String(describing: type(of: self))) deinit")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        super.viewWillAppear(animated)
    }
    
    //MARK: - Add Tap Dismiss Keyboard in View
    func addTapDismissKeyboard() {
        tapDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapDismiss.cancelsTouchesInView = false// ưu tiên action other
        self.view.addGestureRecognizer(tapDismiss)
    }
    
    @objc func dismissKeyboard() {
        print("dismissKeyboard")
        self.view.endEditing(true)
    }
    
    func removeTapDismissKeyboard() {
        if (tapDismiss != nil) {
            self.view.removeGestureRecognizer(tapDismiss)
            tapDismiss = nil
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        addTapDismissKeyboard()
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        removeTapDismissKeyboard()
    }
    
}
