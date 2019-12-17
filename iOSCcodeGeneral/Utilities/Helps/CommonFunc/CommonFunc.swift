//
//  CommonFunc.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit
import SystemConfiguration

class CommonFunc: NSObject {

    //MARK: - Call Phone Number
    class func callPhoneNumber(_ number: String) {
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    //MARK: - CHECK INTERNET
    class func isConnectNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    //MARK: - Open Setting Device
    class func openSettingsDevice(completion: (() -> Void)? = nil){
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                // Handle
            })
        }
    }
    
    //MARK: - Copy Past String
    public static func copyStringToClipboard(_ str: String) {
        UIPasteboard.general.string = str
    }
    public static func pasteStringFromClipboard() -> String? {
        return UIPasteboard.general.string
    }
    
    
}
