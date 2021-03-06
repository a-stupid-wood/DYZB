//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/2.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    //该组中对应的房间信息
    var room_list : [[String : Any]]? {
        didSet {
            guard let roomList = room_list else {return}
            for dict in roomList {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的图标
    var icon_name : String = "home_header_normal_18x18_"
    //定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
}
