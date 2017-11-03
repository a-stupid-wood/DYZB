//
//  CollectionGameCell.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/2.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    //MARK: 定义属性
    var isHideBottomLine : Bool = false {
        didSet {
            bottomLineView.isHidden = isHideBottomLine
        }
    }
    
    //MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomLineView: UIView!
    
    //MARK: 定义模型属性
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            
            let iconURL = URL(string: baseGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
        }
    }

}
