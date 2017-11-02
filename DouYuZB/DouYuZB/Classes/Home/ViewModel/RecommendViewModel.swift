//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/2.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

class RecommendViewModel {

    //MARK:- 懒加载属性
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

//MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData(finishCallBack:@escaping () -> ()) {
        //1.定义参数
         let parameters =  ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        //2.创建dispatch_group
        let dGroup = DispatchGroup()
        
        //3.请求第一部分推荐数据
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1509597801
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else{return}
            
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3.遍历字典，并且转成模型对象
            //3.1设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot_18x18_"
            
            //3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //4.离开组
            dGroup.leave()
        }
        //2.请求第二部分颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1509597801
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else{return}
            
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3.遍历字典，并且转成模型对象
            //3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone_18x18_"
            
            //3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            //4.离开组
            dGroup.leave()
        }
        //3.请求后面部分游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1509597801
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else{return}
            
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            //4.离开组
            dGroup.leave()
        }
        
        //所有的数据请求到之后进行排序
        dGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }))
    }
 
    //请求无限轮播的数据
    func requestCycleData(finishCallBack : @escaping () -> ()) {
        //http://www.douyutv.com/api/v1/slide/6?version=2.542
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.542"]) { (result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else {return}
            
            //2.按照data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3.字典转模型对象
            for dict in dataArray {
                let cycle = CycleModel(dict: dict)
                self.cycleModels.append(cycle)
            }
            
            finishCallBack()
        }
    }

}
