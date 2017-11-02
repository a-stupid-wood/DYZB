//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/1.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    //MARK:- 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK:-定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal_18x18_")
        }
    }
    
}
