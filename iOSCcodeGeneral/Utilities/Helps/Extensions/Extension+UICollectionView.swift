//
//  Extension+UICollectionView.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCell(_ identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
}
