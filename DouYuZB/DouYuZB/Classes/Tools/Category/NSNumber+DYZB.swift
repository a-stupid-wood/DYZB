//
//  NSNumber+DYZB.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

extension NSNumber {
    
    /**
     NSNumber转成NSDate
     
     - returns: 返回转化的成功的NSDate
     */
    func dateWithNumber() -> Date {
        let doubleTempTime = self.doubleValue
        let timeStamp = doubleTempTime as TimeInterval
        return Date(timeIntervalSince1970: timeStamp)
    }
    
    /**
     通过传入一个格式来格式化时间
     
     - parameter format: 时间格式字符串
     
     - returns: 格式化后的时间字符串
     */
    func dateWithFormat(format:String) ->String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let time = Date(timeIntervalSince1970: self.doubleValue as TimeInterval)
        let timeStr:String = formatter.string(from: time)
        return timeStr;
    }
    
    /**
     获得一个格式化后的时间字符串，默认样式为【yyyy-MM-dd HH:mm】
     
     - parameter formatStr:  可以为nil
     
     */
    func dateWithFormatStr(formatStr:String?) -> String {
        let doubleTempTime = self.doubleValue
        let timeStamp = doubleTempTime as TimeInterval
        let date = Date(timeIntervalSince1970: timeStamp)
        
        let fmt = DateFormatter()
        fmt.dateFormat = formatStr != nil ? formatStr : "yyyy-MM-dd HH:mm"
        return fmt.string(from: date)
    }
    
    /**
     是不是同一个月
     
     - parameter timeInterval: 用于比较的时间
     
     - returns: 返回比较的结果
     */
    func isSameMonth(timeInterval:NSNumber)->Bool{
        let date = timeInterval.dateWithNumber()
        let selfDate = dateWithNumber()
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.year,.month,.day], from: date)
        let selfCmps = calendar.dateComponents([.year,.month,.day], from: selfDate)
        return cmps.year == selfCmps.year && cmps.month == selfCmps.month
    }
    
    /**
     是不是本月
     
     - returns: 返回是不是本月的比较结果
     */
    func isCurrentMonth()->Bool{
        let date = dateWithNumber()
        return date.isThisMonth()
    }
    
    func getMonth() ->String {
        let date = dateWithNumber()
        let calendar = Calendar.current
        let month = calendar.dateComponents([.month], from: date)
        return String(month.month!)
    }
    
    func deltaByInterval(interval:NSNumber) -> String {
        let date = interval.dateWithNumber()
        let selfDate = dateWithNumber()
        let cmps = selfDate.deltaByDate(date: date)
        return String(format: "%.2d:%.2d:%.2d", cmps.hour!,cmps.minute!,cmps.second!)
    }
    
    func getWeekDay()->Int {
        let date = dateWithNumber()
        let calendar = Calendar.current
        let weekDay = calendar.dateComponents([.weekday], from: date)
        return weekDay.weekday!
    }
    
}
