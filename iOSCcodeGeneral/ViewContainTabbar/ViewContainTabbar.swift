//
//  ViewContainTabbar.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

class ViewContainTabbar: NibView {

    var selectItemTabbar: ((Int) -> ())?
    
    override func initView() {
        
    }

    @IBAction func act1(_ sender: UIButton) {
        self.selectItemTabbar?(sender.tag)
    }
}
