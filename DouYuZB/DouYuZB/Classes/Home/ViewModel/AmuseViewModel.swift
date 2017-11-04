//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/4.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
    
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroup: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
