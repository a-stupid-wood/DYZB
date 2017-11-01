//
//  UIDevice+DYZB.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

extension UIDevice {
    class func isIPhoneX() -> Bool {
        if UIScreen.main.bounds.height == 812 && UIScreen.main.bounds.width == 375 {
            return true
        }
        return false
    }
    
    class func deviceUUID()->String
    {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
}
