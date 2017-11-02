//
//  NetworkTools.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/1.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : String]? = nil, finishedCallback : @escaping (_ result : AnyObject) -> ()) {
        
        //1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            //3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            //4.将结果回调出去
            finishedCallback(result as AnyObject)
        }
    }
}
