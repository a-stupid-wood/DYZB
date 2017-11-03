
//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/2.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    //MARK: 定义数据属性
    var groups : [AnchorGroup]? {
        didSet {
            //1.移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            //2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            //3.刷新表格
            collectionView.reloadData()
        }
    }

    //MARK: -控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: -系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //注册Cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //给collectionView 添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
    
}

//MARK: -提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//MARK: -遵守UICollectionViewDataSource协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获得cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups![indexPath.item]
        cell.isHideBottomLine = true
        
        return cell
    }
}
