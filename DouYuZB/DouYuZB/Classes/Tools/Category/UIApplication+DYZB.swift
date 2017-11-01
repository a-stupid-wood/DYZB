//
//  UIApplication+DYZB.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

extension UIApplication {
    //MARK:app 沙盒中 “Documents”文件夹的URL
    var documentsURL : URL {
        get{
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        }
    }
    
    //MARK: app 沙盒中 “Documents”文件夹的路径
    var documentsPath:String{
        get{
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        }
    }
    
    //MARK:app 沙盒中 “Caches”文件夹的URL
    var cachesURL:URL{
        get{
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last!
        }
    }
    
    //MARK:app 沙盒中 “Caches”文件夹的路径
    var cachesPath:String{
        get{
            return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        }
    }
    
    //MARK:app 沙盒中 “Libary”文件夹的URL
    var libraryURL:URL{
        get{
            return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last!
        }
    }
    
    //MARK:app 沙盒中 “Libary”文件夹的路径
    var libraryPath:String{
        get{
            return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
        }
    }
    
    //MARK:Application's Bundle Name(show inf SpringBoard)
    var appBundleName:String{
        get{
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        }
    }
    
    //MARK:Application's Bundle ID e.g."com.xmc.DouYuZB"
    var appBundleID:String{
        get{
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
        }
    }
    
    //MARK:Application's Version. e.g. 1.2.0
    var appVersion:String{
        get{
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        }
    }
    
    //MARK:Application's Build number. e.g. "123"
    var appBuildVersion:String{
        get{
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        }
    }
    
    func _yy_fileExistInMainBundle(name:String) -> Bool {
        let bundlePath = Bundle.main.bundlePath
        let path = bundlePath + name
        return FileManager.default.fileExists(atPath:path)
    }
    
    func _delaySetActivity(timer:Timer) {
        let visiable = timer.userInfo as! NSNumber
        if self.isNetworkActivityIndicatorVisible != visiable.boolValue {
            self.isNetworkActivityIndicatorVisible = visiable.boolValue
        }
        timer.invalidate()
    }
}
