//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/4.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    //MARK: -懒加载ViewModel对象
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

//MARK: - 设置UI界面
extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 获取数据
extension FunnyViewController {
    override func loadData() {
        //1.给父类ViewModel赋值
        baseVM = funnyVM
        
        //2.请求数据
        funnyVM.loadFunnyData {
            //2.1.刷新表格
            self.collectionView.reloadData()
            
            //2.2.数据请求完成
            self.loadDataFinished()
        }
    }
}
