//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/1.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    //MARK:-控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK:- 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.显示所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
