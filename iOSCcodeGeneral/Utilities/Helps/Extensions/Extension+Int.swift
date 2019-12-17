//
//  Extension+Int.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension Int {
    func stringValue() -> String {
        return String(self)
    }
    func stringValue(withLength length: Int) -> String {
        return String(format: "%0\(length)d", self)
    }
    
    func covertToFileString() -> String {
        var convertedValue: Double = Double(self)
        var multiplyFactor = 0
        let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
        while convertedValue > 1024 {
            convertedValue /= 1024
            multiplyFactor += 1
        }
        return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
    }
    
    func toDecimaString() -> String {
        var output = ""
        let formatter = NumberFormatter()
//        formatter.alwaysShowsDecimalSeparator = true
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        output = formatter.string(from: NSNumber.init(value: self))!
        return output
    }
    
}
