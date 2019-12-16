//
//  ImageHelper.swift
//  wallet
//
//  Created by Lam Pham on 12/5/19.
//  Copyright © 2019 Lam Pham. All rights reserved.
//

import UIKit

class ImageHelper: NSObject {
    public static func getImageURL(ofUser userID: String) -> URL? {
        let url = ServiceConfig.hostURL + ServiceAddUrl.urlAvatar.rawValue + userID
        return URL.init(string: url)
    }
}
