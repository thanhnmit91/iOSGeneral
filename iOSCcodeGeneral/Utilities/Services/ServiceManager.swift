//
//  ServiceManager.swift
//  wallet
//
//  Created by Lam Pham on 11/12/19.
//  Copyright © 2019 Lam Pham. All rights reserved.
//

import UIKit
import Alamofire

class APIResponse: BaseModel {
    
    @objc dynamic var code = 0
    @objc dynamic var message = ""
    @objc dynamic var mesageStatus = ""
    @objc dynamic var data : Any!
    @objc dynamic var success = false
    @objc dynamic var isDisconnected = false
}

let serviceManager = ServiceManager.sharedInstance

class ServiceManager: NSObject {
    
    static let sharedInstance = ServiceManager()
    
    func request(urlAPI: ServiceAddUrl, method: HTTPMethod, param: Dictionary <String, Any>, success: @escaping((APIResponse)->Void), failure: @escaping((APIResponse)->Void)) {
        
//        Spinner.start(baseColor: AppConstant.MainColor)
        
        let strURL = ServiceConfig.hostURL + urlAPI.rawValue
        
//        if CommonFunc.isConnectNetwork() == false {
//            let error = APIResponse()
//            error.success = false
//            error.message = GlobalConst.NO_NETWORK_CONNECTION_MESSAGE
//            error.isDisconnected = true
//            failure(error)
//            return
//        }
        
        weak var weakself = self
        let dataRequest = prepareRequest(parameter: param as Dictionary<String, AnyObject>)
        
        var headerObject = HTTPHeaders()
//        headerObject = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": userInfoSave.accessToken]
        
        var encoding = URLEncoding.httpBody
        if method == .get {
            encoding = URLEncoding.default
        }
        #if DEBUG
        print("=======================\(method.rawValue.uppercased()) Request \(String(describing: strURL.components(separatedBy: "api/").last))=======")
        print(strURL)
        print(dataRequest)
        #endif
        
        Alamofire.request(strURL, method: method, parameters: dataRequest, encoding: encoding, headers: headerObject).responseJSON { response in
//            Spinner.stop()
            if response.result.value == nil {
                weakself?.notiRefreshTokenFail()
                let error = APIResponse()
                error.success = false
//                error.message = GlobalConst.NO_NETWORK_CONNECTION_MESSAGE
                error.isDisconnected = true
                failure(error)
                return
            }
            let apiResponse = weakself?.processReponse(response: response)
            #if DEBUG
            print("===Response of request \(String(describing: strURL.components(separatedBy: "api/").last))===")
            print(response.result.debugDescription as Any)
            print("=======================End Request \(String(describing: strURL.components(separatedBy: "api/").last))=======")
            #endif
            if (apiResponse?.success == true ) {
                success(apiResponse!)
            }
            else {
                if (apiResponse?.code == ServiceConfig.APIResponseCodeForbidden ||
                    apiResponse?.code == ServiceConfig.APIResponseCodeUnauthorized) {
                    //refresh token
                    weakself?.refreshToken(response: { (resp) in
                        if (resp.success) {
                            //recall api
//                            headerObject = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": userInfoSave.accessToken]
                            weakself?.recallAPI(url: strURL, method: method, params: param, encoding: encoding, header: headerObject, response: { (resp) in
                                if (resp.success) {
                                    // gọi api thành công
                                    success(resp)
                                } else {
                                    // nếu token vẫn sai, buộc end user login lại
                                    if (apiResponse?.code == ServiceConfig.APIResponseCodeForbidden ||
                                        apiResponse?.code == ServiceConfig.APIResponseCodeUnauthorized) {
                                        weakself?.notiRefreshTokenFail()
                                    } else {
                                        // nếu lỗi khác thì xử lý api như bthg
                                        failure(resp)
                                    }
                                }
                            })
                        } else {
                            //refresh token fail
                            weakself?.notiRefreshTokenFail()
                            failure(apiResponse!)
                        }
                    })
                } else {
                    failure(apiResponse!)
                }
            }
        }
    }
    
    private func processReponse(response : DataResponse<Any>) -> APIResponse {
        if(response.result.isSuccess) {
            let dictResponse = response.result.value as! NSDictionary
            let apiResponse = APIResponse()
            if let data = dictResponse.value(forKey: "data") {
                apiResponse.data = data
            }
            if let value = dictResponse.value(forKey: "message") as? String {
//                apiResponse.message = languageShared.getErrorMessage(key: value)
            }
            if let value = response.response?.statusCode {
                apiResponse.code = value
            }
            if let value = dictResponse.value(forKey: "code") as? Int {
                if (value == 1) {
                    apiResponse.success = true
                }
            }
//            if let value = dictResponse.value(forKey: "success") as? Bool {
//                apiResponse.success = value
//            }
            return apiResponse
        }
        else {
            return APIResponse.init()
        }
    }
    
    private func prepareRequest(parameter: Dictionary<String,AnyObject>) -> Parameters {
        var endParameter: Parameters = [:]
        for  (k, v) in parameter {
            endParameter[k] = v
        }
        return (endParameter)
    }
    
    private func refreshToken(response: @escaping((APIResponse) -> Void)) {
        let url = ServiceConfig.hostURL + ServiceAddUrl.refreshToken.rawValue
        let param: Parameters = ["refreshToken":
//            userInfoSave.refreshToken
            ""
        ]
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded",
//                                   "Authorization": userInfoSave.accessToken
        ]
        let encoding = URLEncoding.httpBody
        weak var weakself = self
        
        Alamofire.request(url, method: .post, parameters: param, encoding: encoding, headers: header).responseJSON { (resp) in
            if resp.result.value == nil {
                let error = APIResponse()
                error.success = false
//                error.message = GlobalConst.NO_NETWORK_CONNECTION_MESSAGE
                error.isDisconnected = true
                response(error)
                return
            }
            let apiResponse = weakself?.processReponse(response: resp)
            #if DEBUG
            print(param)
            print("===Response of request \(String(describing: url.components(separatedBy: "api/").last))===")
            print(resp.result.debugDescription as Any)
            print("=======================End Request \(String(describing: url.components(separatedBy: "api/").last))=======")
            #endif
            if (apiResponse?.success == true ) {
                if let data = apiResponse?.data as? NSDictionary {
                    if let token = data.object(forKey: "accessToken") as? String {
//                        userInfoSave.accessToken = token
                    } else {
                        weakself?.notiRefreshTokenFail()
                    }
                } else {
                    weakself?.notiRefreshTokenFail()
                }
            } else {
                if (apiResponse?.code == ServiceConfig.APIResponseCodeForbidden ||
                    apiResponse?.code == ServiceConfig.APIResponseCodeUnauthorized) {
                    weakself?.notiRefreshTokenFail()
                }
            }
            response(apiResponse!)
        }
    }
    
    private func notiRefreshTokenFail() {
//        NotificationCenter.default.post(name: NSNotification.Name.init(AppConstant.NotificationTokenExpiredName), object: nil)
    }
    
    private func recallAPI(url: String, method: HTTPMethod, params: Parameters, encoding: URLEncoding, header: HTTPHeaders, response: @escaping((APIResponse) -> Void)) {
        weak var weakself = self
        Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: header).responseJSON { (resp) in
            if resp.result.value == nil {
                let error = APIResponse()
                error.success = false
//                error.message = GlobalConst.NO_NETWORK_CONNECTION_MESSAGE
                error.isDisconnected = true
                response(error)
                return
            }
            let apiResponse = weakself?.processReponse(response: resp)
            #if DEBUG
            print("===Response of request \(String(describing: url.components(separatedBy: "api/").last))===")
            print(resp.result.debugDescription as Any)
            print("=======================End Request \(String(describing: url.components(separatedBy: "api/").last))=======")
            #endif
            if (apiResponse?.success == true ) {
                response(apiResponse!)
            }
            else {
                if (apiResponse?.code == ServiceConfig.APIResponseCodeForbidden ||
                    apiResponse?.code == ServiceConfig.APIResponseCodeUnauthorized) {
                    weakself?.notiRefreshTokenFail()
                }
                response(apiResponse!)
            }
        }
    }
}


extension ServiceManager {
    
    func request(path: String, method: HTTPMethod, param: Dictionary <String, Any>, success: @escaping((APIResponse)->Void), failure: @escaping((APIResponse)->Void)) {
        
        let strURL = ServiceConfig.hostURL + path
        
//        if CommonFunc.isConnectNetwork() == false {
//            let error = APIResponse()
//            error.success = false
//            error.message = GlobalConst.NO_NETWORK_CONNECTION_MESSAGE
//            error.isDisconnected = true
//            failure(error)
//            return
//        }
        
        weak var weakself = self
        let dataRequest = prepareRequest(parameter: param as Dictionary<String, AnyObject>)
        
        var headerObject = HTTPHeaders()
//        headerObject = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": userInfoSave.accessToken]
        
        var encoding = URLEncoding.httpBody
        if method == .get {
            encoding = URLEncoding.default
        }
        #if DEBUG
        print("=======================\(method.rawValue.uppercased()) Request \(String(describing: strURL.components(separatedBy: "api/").last))=======")
        print(strURL)
        print(dataRequest)
        #endif
        
        Alamofire.request(strURL, method: method, parameters: dataRequest, encoding: encoding, headers: headerObject).responseJSON { response in
            if response.result.value == nil {
                weakself?.notiRefreshTokenFail()
                let error = APIResponse()
                error.success = false
//                error.message = GlobalConst.NO_NETWORK_CONNECTION_MESSAGE
                error.isDisconnected = true
                failure(error)
                return
            }
            let apiResponse = weakself?.processReponse(response: response)
            #if DEBUG
            print("===Response of request \(String(describing: strURL.components(separatedBy: "api/").last))===")
            print(response.result.debugDescription as Any)
            print("=======================End Request \(String(describing: strURL.components(separatedBy: "api/").last))=======")
            #endif
            if (apiResponse?.success == true ) {
                success(apiResponse!)
            }
            else {
                if (apiResponse?.code == ServiceConfig.APIResponseCodeForbidden ||
                    apiResponse?.code == ServiceConfig.APIResponseCodeUnauthorized) {
                    //refresh token
                    weakself?.refreshToken(response: { (resp) in
                        if (resp.success) {
                            //recall api
//                            headerObject = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": userInfoSave.accessToken]
                            weakself?.recallAPI(url: strURL, method: method, params: param, encoding: encoding, header: headerObject, response: { (resp) in
                                if (resp.success) {
                                    // gọi api thành công
                                    success(resp)
                                } else {
                                    // nếu token vẫn sai, buộc end user login lại
                                    if (apiResponse?.code == ServiceConfig.APIResponseCodeForbidden ||
                                        apiResponse?.code == ServiceConfig.APIResponseCodeUnauthorized) {
                                        weakself?.notiRefreshTokenFail()
                                    } else {
                                        // nếu lỗi khác thì xử lý api như bthg
                                        failure(resp)
                                    }
                                }
                            })
                        } else {
                            //refresh token fail
                            weakself?.notiRefreshTokenFail()
                            failure(apiResponse!)
                        }
                    })
                } else {
                    failure(apiResponse!)
                }
            }
        }
    }
}
