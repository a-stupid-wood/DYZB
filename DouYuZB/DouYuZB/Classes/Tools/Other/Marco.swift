//
//  Marco.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit


/// 传入适配iPhone6的宽度返回根据屏幕宽度计算出适配宽度
///
/// - Parameter width: 适配iPhone6的宽度
/// - Returns: 适配宽度
func DYZB_RealWidth(width : CGFloat) -> CGFloat {
    return (width / 375.0) * UIScreen.main.bounds.width
}

/// 传入适配iPhone6的高度返回根据屏幕宽度计算出适配高度
///
/// - Parameter height: 适配iPhone6的高度
/// - Returns: 适配高度
func DYZB_RealHeight(height : CGFloat) -> CGFloat {
    return (height / 667.0) * UIScreen.main.bounds.height
}
//屏幕宽度
let kScreenWidth : CGFloat = UIScreen.main.bounds.size.width
//屏幕高度
let kScreenHeight : CGFloat = UIScreen.main.bounds.size.height
//系统版本
let kSystemVersion : Double = {
    let systemVersion = UIDevice.current.systemVersion
    let version = Double(systemVersion.substring(to: systemVersion.index(systemVersion.index(of: ".")!, offsetBy: 2)))
    return version!
}()
//导航栏高度
let kNavHeight : CGFloat = 44.0
//状态栏高度
let kStatusBarHeight : CGFloat = UIDevice.isIPhoneX() ? 44.0 : 20.0
//状态栏和导航栏的高度
let kNavAndStatusBarHeight : CGFloat = kNavHeight + kStatusBarHeight
//工具栏的高度
let kTabBarHeight : CGFloat = UIDevice.isIPhoneX() ? 83.0 : 49.0




