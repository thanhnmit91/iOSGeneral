//
//  Spinner.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/16/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

open class Spinner {
    
    internal static var spinner: UIActivityIndicatorView?
    public static var style: UIActivityIndicatorView.Style = .whiteLarge
    public static var baseBackColor = UIColor.black.withAlphaComponent(0.5)
    public static func start(style: UIActivityIndicatorView.Style = .whiteLarge, backColor: UIColor = baseBackColor, baseColor: UIColor) {
//        NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
        DispatchQueue.main.async {
            if spinner == nil, let window = UIApplication.shared.keyWindow {
                let frame = UIScreen.main.bounds
                spinner = UIActivityIndicatorView(frame: frame)
                spinner!.backgroundColor = backColor
                spinner!.style = style
                spinner?.color = baseColor
                window.addSubview(spinner!)
                spinner!.startAnimating()
            }
        }
    }
    public static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    @objc public static func update() {
        if spinner != nil {
            stop()
//            start()
        }
    }
}
