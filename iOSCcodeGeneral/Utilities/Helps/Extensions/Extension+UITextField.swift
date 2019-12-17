//
//  Extension+UITextField.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension UITextField {

    //MARK: - limit Input
    func limitLeghtInput(_ numberLimit: Int, range: NSRange, string: String) -> Bool{
        guard let textFieldText = self.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= numberLimit
    }
    
}
