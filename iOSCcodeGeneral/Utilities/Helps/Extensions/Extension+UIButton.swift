//
//  Extension+UIButton.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension UIButton {
    func disable() {
        self.alpha = 0.5
        self.isUserInteractionEnabled = false
    }
    func enable() {
        self.alpha = 1.0
        self.isUserInteractionEnabled = true
    }
}
