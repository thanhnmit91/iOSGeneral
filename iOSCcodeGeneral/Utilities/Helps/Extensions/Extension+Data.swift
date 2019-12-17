//
//  Extension+Data.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
