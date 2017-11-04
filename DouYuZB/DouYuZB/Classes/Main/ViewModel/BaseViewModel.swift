//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/4.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroup: Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback: @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            //1.对结果进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //2.判断是否是分组数据
            if isGroup {
                //2.1.遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }else {
                //2.1.创建组
                let group = AnchorGroup()
                
                //2.2.遍历dataArray的所有字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                //2.3.将group添加到anchorGroups
                self.anchorGroups.append(group)
            }
            
            
            //3.完成回调
            finishedCallback()
        }
    }
}
