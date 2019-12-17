//
//  Extension+UIViewController.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension UIViewController {
    //MARK: - Show Action Sheet
    func showActionSheet(arrDics: [String],hanldeAmerican: ((String) -> Void)?){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in arrDics {
            let actionLanguage = UIAlertAction(title: "\(item)", style: .default) { (alert) in
                hanldeAmerican?(item)
            }
            alertController.addAction(actionLanguage)
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = self.view
            alertController.popoverPresentationController?.sourceRect = self.view.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.present(alertController, animated: true)
    }
    
    //MARK: - Check isModal
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    //MARK: - Show Alert Top to Bottom
    func showSuccess(title: String = "",message: String) {
        // check nếu đang hiển thị 1 alert rồi thì ko hiển thị tiếp nữa
        for controller in self.children {
            if controller is AlertsViewController {
                controller.removeFromParent()
                controller.view.removeFromSuperview()
            }
        }
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let vc = AlertsViewController(title: title, detail: message)
        window?.addSubview(vc.view)
        vc.viewContains.backgroundColor = UIColor.blue
        vc.view.frame = CGRect(x: 0, y: 0, width: (window?.frame)!.width, height: vc.viewContains.bounds.height)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    //=========================== 19/06/2018 11:23 PM
    /**
     *  Show alert view
     */
    func showAlert(title: String, content: String, handler: @escaping(() -> Void)) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            handler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    //=========================== 19/06/2018 11:23 PM
    /**
     *  Show alert confirm view
     */
    func showAlertConfirm(title: String, content: String, handler: @escaping(() -> Void)) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            handler()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //=========================== 02/08/2018 11:55 AM
    func presentSamePopup(_ target : UIViewController,competion: @escaping (()->Void)) {
        target.modalPresentationStyle = .overCurrentContext
        target.modalTransitionStyle = .coverVertical
        present(target, animated: true) {
            competion()
        }
    }
    
    //MARK: - Add Child Controller
    func displayContentController(content: UIViewController) {
        addChild(content)
        self.view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    //MARK: - Add Remove Controller
    func hideContentController(content: UIViewController) {
        content.willMove(toParent: nil)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
    
}
