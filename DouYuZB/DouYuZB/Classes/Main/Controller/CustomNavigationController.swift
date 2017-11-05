//
//  CustomNavigationController.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/4.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1.获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        //2.获取手势添加到view中
        guard let gesView = systemGes.view else { return }
        
        //3.获取target/action
        //3.1.利用运行时机制查看所有属性名称
       /* var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0 ..< count {
            let ivar = ivars![Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }*/
        //3.1.取出系统手势的targets
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        //3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        //3.3.取出action
        let action = Selector(("handleNavigationTransition:"))
        
        //4.创建自己的pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}