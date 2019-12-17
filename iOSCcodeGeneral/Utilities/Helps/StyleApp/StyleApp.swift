//
//  StyleApp.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/16/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

enum AppFont: String {
    case regular = "Roboto-Regular"
    case medium = "Roboto-Medium"
    case light = "Roboto-Light"
    case bold = "Roboto-Bold"
    case italic = "Roboto-Italic"
    case lightItalic = "Roboto-LightItalic"
    func sizeFont(withSize size: FontSize) -> UIFont {
        return UIFont(name: self.rawValue, size: CGFloat(size.rawValue)) ?? UIFont.systemFont(ofSize: CGFloat(size.rawValue))
    }
    
    static func setFontPlaceholder() -> UIFont {
        return AppFont.light.sizeFont(withSize: .h16)
    }
    
}

enum FontSize: Int {
    case h8 = 8
    case h9 = 9
    case h10 = 10
    case h11 = 11
    case h12 = 12
    case h13 = 13
    case h14 = 14
    case h16 = 16
    case h15 = 15
    case h18 = 18
    case h20 = 20
    case h22 = 22
    case h24 = 24
    case h26 = 26
    case h28 = 28
    case h50 = 50
    case h100 = 100
    
}
