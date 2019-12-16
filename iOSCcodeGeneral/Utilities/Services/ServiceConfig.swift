//
//  ServiceConfig.swift
//  PINO
//
//  Created by Lâm Phạm on 6/4/18.
//  Copyright © 2018 lampham. All rights reserved.
//

import UIKit

class ServiceConfig: NSObject {
    
    // url
    public static let hostURL = "http://139.99.123.117:1338/api/v1/"
    
    // api code
    public static let APIResponseCodeUnauthorized       = 401
    public static let APIResponseCodeForbidden          = 403
}

enum ServiceAddUrl: String {
    
    //get config
    case globalConfig = "static/globalConfig"
    
    //Login
    case login = "userAccount/login"
    
    //Register
    case registerOTP = "userAccount/otp"
    case register = "userAccount/register"
    case updateInfoUser = "userAccount/updateDetails"
    
    
    //Forgot Pass
    case forgotPassOTP = "userAccount/getOTPForgotPassword"
    case verifyOTP = "userAccount/verifyOTPForgotPassword"
    case resetPass = "userAccount/resetPassword"
    
    //Create Pin
    case createPinCode = "userAccount/createPinCode"
    case verifyPinCode = "userAccount/verifyPinCode"
    case changePinCode = "userAccount/changePinCode"
    
    //Change Pass
    case changePass    = "userAccount/changePassword"
    
    case getTransaction = "userAccount/getTransactions"
    case getTransactionByID = "userAccount/transactionDetail/"
    //Get detail User
    case getDetailUser = "userAccount/detail"
    case urlAvatar     = "static/avatar/"
    
    
    //Get bank
    case getBank       = "static/supportedBankByCountry"
    
    //Exchange
    case exchangeCurrency = "static/exchangeRate"
    
    //Request
    case requestWithdraw  = "userAccount/requestWithdraw"
    
    //Transfer Point
    case transferPoint    = "userAccount/transferPoint"
    case otherUserInfo    = "userAccount/otherUserInfo"
    
    case getListBranch = "static/getListBranch"
    
    case refreshToken = "userAccount/renewAccessToken"
    
    case getPoints = "static/pointList"
    
    case getNotifyGroup = "userAccount/notificationGroups"
    
    case getNotifyList = "userAccount/notificationList"
    
    //requestTopup
    case requestTopup = "userAccount/requestTopup"
    
    //getOTPTransferPoint
    case getOTPTransferPoint    = "userAccount/getOTPTransferPoint"
    case verifyOTPTransferPoint = "userAccount/verifyOTPTransferPoint"
    
    //logout
    case logout = "userAccount/logout"
}







