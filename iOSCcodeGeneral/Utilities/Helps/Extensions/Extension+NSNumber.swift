//
//  Extension+NSNumber.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension NSNumber {
    func toDecimaString() -> String {
        var output = ""
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        output = formatter.string(from: self) ?? ""
        return output
    }
}
