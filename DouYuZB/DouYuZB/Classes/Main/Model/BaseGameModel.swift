//
//  BaseGameModel.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/3.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    //MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    override init() {
        super.init()
    }
    
    //MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
