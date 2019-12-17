//
//  Extension+Error.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension Error {
    func getMessage() -> String {
        return (self as NSError).domain
    }
    func getCode() -> Int {
        return (self as NSError).code
    }
}
