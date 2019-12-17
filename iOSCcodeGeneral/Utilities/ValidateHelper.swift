//
//  ValidateHelper.swift
//  wallet
//
//  Created by Lam Pham on 11/14/19.
//  Copyright © 2019 Lam Pham. All rights reserved.
//

import UIKit

enum RegEx: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" // Email
    case password = "^.{6,15}$" // Password length 6-15
    case alphabeticStringWithSpace = "^[a-zA-Z ]*$" // e.g. hello sandeep
    case alphabeticStringWithNoSpace = "^[a-zA-Z0-9]*$" // e.g. hellosandeep
    case alphabeticStringFirstLetterCaps = "^[A-Z]+[a-zA-Z]*$" // SandsHell
    case phoneNo = "[0-9]{10,14}" // PhoneNo 10-14 Digits        //Change RegEx according to your Requirement
    case passwordHasOneLetterAndLetterCaps = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}$"
}

class ValidateHelper: NSObject {

    //MARK: Validate Email
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    //MARK: Validate Phone
    static func isValidatePhone(_ phone: String) -> Bool {
        return phone.count >= 9 && phone.count <= 11
    }
    
    //MARK: Validate Password
    static func validatePassword(_ pass: String) -> Bool {
//        if self.count < 6 { return false }
        //Minimum six characters, at least one letter and one number:
        let capitalLetterRegEx  = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: pass) else { return false }
        
//        let numberRegEx  = ".*[0-9]+.*"
//        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
//        guard texttest1.evaluate(with: self) else { return false }
        
//        let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
//        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
//        guard texttest2.evaluate(with: self) else { return false }
        
        return true
    }
    
    //MARK: - ValidateRegEx
    class func isValidRegEx(_ testStr: String, _ regex: RegEx) -> Bool {
        let stringTest = NSPredicate(format:"SELF MATCHES %@", regex.rawValue)
        let result = stringTest.evaluate(with: testStr)
        return result
    }
}
