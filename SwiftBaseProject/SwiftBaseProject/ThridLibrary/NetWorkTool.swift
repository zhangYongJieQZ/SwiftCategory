//
//  NetWorkTool.swift
//  StudentPaySwift
//
//  Created by zhangyongjie on 2017/4/10.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import Foundation
import AFNetworking
import SVProgressHUD

enum RequestType: String{
 case GET = "GET"
 case POST = "POST"
}

class NetWorkTool: AFHTTPSessionManager {

    static let shareInstance : NetWorkTool = {
        let toolInstance = NetWorkTool()
        toolInstance.responseSerializer.acceptableContentTypes?.insert("text/html");
        toolInstance.responseSerializer.acceptableContentTypes?.insert("application/json");
        toolInstance.responseSerializer.acceptableContentTypes?.insert("text/json");
        toolInstance.responseSerializer.acceptableContentTypes?.insert("text/javascript");
        return toolInstance
    }()
    
    // 将成功和失败的回调写在一个逃逸闭包中
    func request(requestType : RequestType, url : String, parameters : [String : Any], resultBlock : @escaping(Any?, Error?) -> ()) {
        print("requstUrl = " + url)
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            SVProgressHUD.dismiss()
            print(responseObj ?? "请求出错")
            let responseDit = responseObj as! NSDictionary
            if responseDit.value(forKey: "status") as! Int == 401{
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: logoutNotification), object: nil)
            }
            if responseDit.value(forKey: "status") as! Int != 200 {
                SVProgressHUD.show(nil, status: responseDit.value(forKey: "message") as! String)
            }
            resultBlock(responseObj , nil)
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            SVProgressHUD.dismiss()
            SVProgressHUD.show(nil, status: "网络链接错误，请重试")
            resultBlock(nil, error)
        }
        
        // Get 请求
        if requestType == .GET {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post 请求
        if requestType == .POST {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }
    
    // 将成功和失败的回调分别写在两个逃逸闭包中
    func request(requestType : RequestType, url : String, parameters : [String : Any], succeed : @escaping(Any?) -> (), failure : @escaping(Error?) -> ()) {
        print("requstUrl = " + url)
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            SVProgressHUD.dismiss()
            print(responseObj ?? "请求出错")
            let responseDit = responseObj as! NSDictionary
            if responseDit.value(forKey: "status") as! Int == 401{
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: logoutNotification), object: nil)
            }
            if responseDit.value(forKey: "status") as! Int != 200{
                SVProgressHUD.show(nil, status: responseDit.value(forKey: "message") as! String)
            }
            succeed(responseObj)
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            SVProgressHUD.dismiss()
            SVProgressHUD.show(nil, status: "网络链接错误，请重试")
            failure(error)
        }
        
        // Get 请求
        if requestType == .GET {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post 请求
        if requestType == .POST {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }

    func uploadImage(requestType: RequestType, url:String, parameters : [String : Any], file:UIImage, succeed : @escaping(Any?) -> (), failure : @escaping(Error?) -> ()){
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            print(responseObj ?? "请求出错")
            succeed(responseObj)
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
        post(url, parameters: parameters, constructingBodyWith: { (formData) in
            let imageData = UIImageJPEGRepresentation(file, 0.3)
            let fileString = String.init(NSString.init(format: "%@", NSDate.init(timeIntervalSinceNow: 0).timeIntervalSince1970))
            formData.appendPart(withFileData: imageData!, name: "body", fileName: fileString, mimeType: "image/jpeg")
        }, progress: { (progress) in
            
        }, success: successBlock, failure: failureBlock)
        
    }
    
}
