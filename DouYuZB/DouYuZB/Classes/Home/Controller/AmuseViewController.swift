//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/4.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    //MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenWidth, height: kMenuViewH)
        return menuView
    }()
   
}

//MARK:- 设置UI界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        //将菜单的view添加到collectionView中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 请求数据
extension AmuseViewController {
    override func loadData() {
        //1.给父类中ViewModel进行赋值
        baseVM = amuseVM
        
        //请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
        }
    }
}


