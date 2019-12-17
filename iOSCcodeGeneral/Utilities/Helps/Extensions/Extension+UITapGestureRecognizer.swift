//
//  Extension+UITapGestureRecognizer.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension UITapGestureRecognizer {
    
    // tap string in text Label
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension Range where Bound == String.Index {
    var nsRange:NSRange {
        return NSRange(location: self.lowerBound.encodedOffset,
                       length: self.upperBound.encodedOffset -
                        self.lowerBound.encodedOffset)
    }
}


//MARK: - Use
//func addTapGesture()
//{
//    let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(tap:)))
//    self.addGestureRecognizer(tap)
//    self.isUserInteractionEnabled = true
//}
//
//@objc func tapLabel(tap: UITapGestureRecognizer) {
//    guard let range = self.text?.range(of: languageShared.getText(ofKey: .service_agreement))?.nsRange else {
//        return
//    }
//    if tap.didTapAttributedTextInLabel(label: self, inRange: range) {
//        // Substring tapped
//        self.didTapServiceAgreement?()
//    }
//}
