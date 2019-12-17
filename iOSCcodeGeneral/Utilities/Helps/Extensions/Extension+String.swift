//
//  Extension+String.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension String{
    
    //MARK: - REMOVE Charater in String
    func removeCharacterInString(_ character: String = ",") -> String{
        return self.replacingOccurrences(of: character, with: "")
    }
    
    //MARK: - Attribute Font, Color
    func setAttributeString(changeStr: String, fontChange: UIFont, colorFont: UIColor = UIColor.white) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: changeStr)
        attributeString.addAttribute(NSAttributedString.Key.font, value: fontChange, range: range)
        if colorFont != UIColor.white {
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: colorFont, range: range)
        }
        return attributeString
    }
    
    //MARK: - CHECK IS Number in String
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func appendingPathComponent(_ string: String) -> String {
        return URL(fileURLWithPath: self).appendingPathComponent(string).path
    }
    
    func sizeForLocalFilePath() -> UInt64 {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: self)
            if let fileSize = fileAttributes[FileAttributeKey.size]  {
                return (fileSize as! NSNumber).uint64Value
            } else {
                print("Failed to get a size attribute from path: \(self)")
            }
        } catch {
            print("Failed to get file attributes for local path: \(self) with error: \(error)")
        }
        return 0
    }
   
    func documentPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let directoryPath = paths[0]
        return directoryPath.appendingPathComponent(self)
    }
    
    func saveFileLocal() {
        let pathDoc = self.documentPath()
        let fileExists = FileManager.default.fileExists(atPath: pathDoc)
        if !fileExists {
            do {
                try NSData().write(toFile: self.documentPath(), options: NSData.WritingOptions.atomic)
            }catch{
                
            }
        }
    }
    
    mutating func convertStringToNumberCard() -> String {
        if (self.count == 4) || (self.count == 9) || self.count == 14 {
            self = self + " "
        }
        return self
    }
    
    func removeVN() -> String {
        let data: Data? = self.data(using: String.Encoding.ascii, allowLossyConversion: true)
        let newStrCheck = String(data: data!, encoding: String.Encoding.ascii)
        return newStrCheck!
    }
    
    //MARK: - Currency Input Formatting
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currencyAccounting
        formatter.locale = Locale.current
        formatter.currencyGroupingSeparator = "."
        formatter.currencySymbol = ""
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 1))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    //MARK: - Set Underline String
    func setUnderlineString() -> NSMutableAttributedString {
        let textRange = NSMakeRange(0, self.count)
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        return attributedText
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
    
    //MARK: Convert String to Flag String
    func flag() -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in self.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
}
