//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/2.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间号
    var room_id : Int = 0
    //房间图片对应的URLString
    var vertical_src : String = ""
    //判断是手机直播还是电脑质保
    //0:电脑直播 1:手机直播
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //观看人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
