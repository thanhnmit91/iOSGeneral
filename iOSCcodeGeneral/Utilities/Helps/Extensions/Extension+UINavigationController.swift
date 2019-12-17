//
//  Extension+UINavigationController.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension UINavigationController {

  //pop for Class
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
      popToViewController(vc, animated: animated)
    }
  }
    
  //pop for index
  func popViewControllers(viewsToPop: Int, animated: Bool = true) {
    if viewControllers.count > viewsToPop {
      let vc = viewControllers[viewControllers.count - viewsToPop - 1]
      popToViewController(vc, animated: animated)
    }
  }

}
