//
//  Date+DYZB.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

extension Date {
    
    //MARK:是否为今天
    func isToday() -> Bool {
        let calendar = Calendar.current
        //获取当前时间的年月日
        let nowCmps = calendar.dateComponents([.day,.month,.year], from: Date())
        //获取self的年月日
        let selfCmps = calendar.dateComponents([.day,.month,.year], from: self)
        
        return selfCmps.year == nowCmps.year && selfCmps.month == nowCmps.month && selfCmps.day == nowCmps.day
    }
    
    //MARK:是否为昨天
    func isYesterday() -> Bool {
        //获得根据年月日得到的当前时间
        let nowDate = Date().dateWithYMD()
        //获得根据年月日得到的self时间
        let selfDate = dateWithYMD()
        //获得nowDate和selfDate之间的差距
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.day], from: selfDate, to: nowDate)
        
        return cmps.day == 1
    }
    
    //MARK:根据年月日得到Date
    func dateWithYMD() -> Date {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let selfStr = fmt.string(from: self)
        return fmt.date(from: selfStr)!
    }
    
    //MARK:获得当前时间年月日字符串
    func yearMonthDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let currentDateString = dateFormatter.string(from: Date())
        return currentDateString
    }
    
    //是否是本月
    func isThisMonth() -> Bool {
        let calendar = Calendar.current
        //获得当前时间的年月日
        let currentCmps = calendar.dateComponents([.year,.month], from: Date())
        //获得self的年月日
        let selfCmps = calendar.dateComponents([.year,.month], from: self)
        
        return currentCmps.year == selfCmps.year && currentCmps.month == selfCmps.month
        
    }
    
    //MARK:是否是今年
    func isThisYear() -> Bool {
        let calendar = Calendar.current
        //获得当前时间的年月日
        let nowCmps = calendar.dateComponents([.year], from: Date())
        //获得self的年月日
        let selfCmps = calendar.dateComponents([.year], from: Date())
        
        return nowCmps.year == selfCmps.year
    }
    
    //MARK:获得与当前时间的间隔(时分秒)
    func deltaWithNow() -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.hour
            ,.minute,.second], from: self, to: Date())
    }
    
    //MARK:获得与当前时间的间隔(年月日时分秒)
    private func private_deltaWithNow() -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.year,.month,.day,.hour
            ,.minute,.second], from: self, to: Date())
    }
    
    //MARK:获得与某个时间的间隔
    func deltaByDate(date:Date) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.hour,.minute,.second], from: date, to: self)
    }
    
    
    /// 格式化时间
    ///
    /// - Parameter number: 时间戳
    /// - Returns: 时间段的表示
    static func formatTimerWithNumber(number:NSNumber) -> String {
        let doubleTempTime = number.doubleValue / 1000
        let timestamp = doubleTempTime as TimeInterval
        let date = Date(timeIntervalSince1970: timestamp)
        
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        
        //判断是不是今年
        if date.isThisYear() {
            let cmps = date.private_deltaWithNow()
            if date.isToday() {//今天
                if cmps.hour! >= 1 {
                    return String(cmps.hour!) + "小时前"
                }else if cmps.minute! >= 1 {//1~59分钟前发的
                    return String(cmps.minute!) + "分钟前"
                }else {//1分钟内
                    return "刚刚"
                }
            }else if date.isYesterday() {//昨天
                fmt.dateFormat = "昨天 HH:mm"
                return fmt.string(from: date)
            }else if cmps.day! < 30 {//至少是前天
                return String(cmps.day!) + "天前"
            }else {//至少一个月前
                fmt.dateFormat = "MM-dd HH:mm"
                return fmt.string(from: date)
            }
        }else {//至少是一年前
            fmt.dateFormat = "yyyy-MM-dd"
            return fmt.string(from: date)
        }
    }
    
    func timeFromThen(number : NSNumber) -> String {
        let doubleTempTime = number.doubleValue / 1000
        let timeStamp = doubleTempTime as TimeInterval
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString = dateFormatter.string(from: date)
        let newsDate = dateFormatter.date(from: dateString)
        let timeZone = TimeZone(abbreviation: "CST")
        dateFormatter.timeZone = timeZone
        
        let currentDate = Date()
        let time = currentDate.timeIntervalSince(newsDate!)
        //间隔秒数
        let month = Int(time)/(3600 * 24 * 30)
        let days = Int(time) / (3600 * 24)
        let hours = Int(time) % (3600 * 24) / 3600
        let minutes = Int(time) % (3600 * 24) / 60
        
        let dateContent:String
        if month != 0 {
            dateContent = "  " + String(month) + "个月前"
        }else if days != 0{
            dateContent = "  " + String(days) + "天前"
        }else if hours != 0{
            dateContent = "  " + String(hours) + "小时前"
        }else{
            if minutes == 0 {
                dateContent = "刚刚"
            }else
            {
                dateContent = "  " + String(minutes) + "分钟前"
            }
        }
        return dateContent
    }
    
    var self_year : String {
        get{
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy"
            return fmt.string(from: self)
        }
    }
    
    var self_month : String {
        get{
            let fmt = DateFormatter()
            fmt.dateFormat = "MM"
            return fmt.string(from: self)
        }
    }
    
    var self_day : String {
        get{
            let fmt = DateFormatter()
            fmt.dateFormat = "dd"
            return fmt.string(from: self)
        }
    }
    
    var self_hour : String {
        get{
            let fmt = DateFormatter()
            fmt.dateFormat = "HH"
            return fmt.string(from: self)
        }
    }
    
    var self_minute : String {
        get {
            let fmt = DateFormatter()
            fmt.dateFormat = "mm"
            return fmt.string(from: self)
        }
    }
    
    var self_second : String {
        get {
            let fmt = DateFormatter()
            fmt.dateFormat = "ss"
            return fmt.string(from: self)
        }
    }
    
    //MARK:生成分秒格式的时间
    static func formatTimeToMinSecWithNumber(number : NSNumber) -> String {
        let doubleTempTime = number.intValue
        return String(doubleTempTime / 60) + ":" + String(doubleTempTime % 60)
    }
    
    //MARK:生成年-月-日 时:分的时间
    static func formatTimeToYMDHM(number : NSNumber) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = "YYYY-MM-dd HH:mm"
        
        //        let timeZone = TimeZone(abbreviation: "GMT") // Greenwich Mean Time
        //        let timeZone = TimeZone(abbreviation: "CET") // Central European Time
        let timeZone = TimeZone(abbreviation: "CST") // China Standard Time
        formatter.timeZone = timeZone
        let doubleTempTime = number.doubleValue / 1000
        let timeStamp = doubleTempTime as TimeInterval
        let conformTimesp = Date(timeIntervalSince1970: timeStamp)
        let confirmTimespStr = formatter.string(from: conformTimesp)
        return confirmTimespStr
    }
    
    static func getCurrentTime() ->String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}

