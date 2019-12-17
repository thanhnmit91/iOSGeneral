//
//  Extension+UIImageView.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit
import AlamofireImage

let IMG_DEFAULT_AVATAR = #imageLiteral(resourceName: "user_default")
let IMG_DEFAULT = #imageLiteral(resourceName: "transaction_default_avatar")

extension UIImageView {
    /**
     *  Set Avatar with default image using AlamofireImage
     *  param:  URL?
     */
    func setAvatar(withURL url: URL) {
        self.af_setImage(withURL: url, placeholderImage: UIImage(), filter: nil, progress: nil, progressQueue: .global(), imageTransition: UIImageView.ImageTransition.crossDissolve(0.3), runImageTransitionIfCached: false) { [weak self] (response) in
            if let img = response.result.value {
                self?.image = img
            }else{
                self?.image = IMG_DEFAULT_AVATAR
            }
        }
    }
    
    /**
     *  Set Image with URL using AlamofireImage
     *  param:  URL?
     */
    func setImage(withURL url: URL) {
        self.af_setImage(withURL: url, placeholderImage: UIImage(), filter: nil, progress: nil, progressQueue: .global(), imageTransition: UIImageView.ImageTransition.crossDissolve(1), runImageTransitionIfCached: false) { [weak self] (response) in
            if let img = response.result.value {
                self?.image = img
            }else{
                self?.image = IMG_DEFAULT
            }
        }
    }
}

extension UIImage {
    
    //MARK: - RESIZE IMAGE
    func resize(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    //MARK: - CONVERT IMAGE TO BASE64
    func convertImageToBase64() -> String {
        let imageData:NSData = self.jpegData(compressionQuality: 0.4)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }

}
