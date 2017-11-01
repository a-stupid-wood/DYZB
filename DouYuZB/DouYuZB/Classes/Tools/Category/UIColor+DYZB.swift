//
//  UIColor+DYZB.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

extension UIColor {
    class func commonColor(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    class func color(rgbHexValue:NSInteger, alpha:CGFloat = 1.0) -> UIColor {
        return UIColor.commonColor(red: CGFloat(rgbHexValue & 0xFF0000), green: CGFloat(rgbHexValue & 0xFF00), blue: CGFloat(rgbHexValue & 0xFF),alpha: alpha)
    }
    
    class func colorWithHexString(hexString:String) -> UIColor {
        var cleanString = hexString.lowercased()
        if let range = hexString.range(of: "#") {
            cleanString = hexString.replacingCharacters(in: range, with: "")
        }
        if let range = cleanString.range(of: "0x") {
            cleanString = cleanString.replacingCharacters(in: range, with: "")
        }
        if cleanString.characters.count == 3 {
            cleanString = cleanString.substring(to: cleanString.index(cleanString.startIndex, offsetBy: 1)) + cleanString.substring(to: cleanString.index(cleanString.startIndex, offsetBy: 1)) + cleanString.substring(with: cleanString.index(cleanString.startIndex, offsetBy: 1) ..< cleanString.index(cleanString.startIndex, offsetBy: 2)) + cleanString.substring(with: cleanString.index(cleanString.startIndex, offsetBy: 1) ..< cleanString.index(cleanString.startIndex, offsetBy: 2)) + cleanString.substring(with: cleanString.index(cleanString.startIndex, offsetBy: 2) ..< cleanString.index(cleanString.startIndex, offsetBy: 3)) + cleanString.substring(with: cleanString.index(cleanString.startIndex, offsetBy: 2) ..< cleanString.index(cleanString.startIndex, offsetBy: 3))
            
        }
        cleanString = cleanString + "ff"
        var baseValue : UInt32 = 0
        Scanner(string: cleanString).scanHexInt32(&baseValue)
        let red = CGFloat((baseValue >> 24) & 0xFF)
        let green = CGFloat((baseValue >> 16) & 0xFF)
        let blue = CGFloat((baseValue >> 8) & 0xFF)
        let alpha = CGFloat((baseValue >> 0) & 0xFF)
        
        return UIColor.commonColor(red: red, green: green, blue: blue, alpha:alpha)
    }
    
    class func randomColor() -> UIColor {
        return UIColor.commonColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
    }
}
