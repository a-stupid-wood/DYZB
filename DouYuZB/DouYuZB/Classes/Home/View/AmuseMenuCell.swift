//
//  AmuseMenuCell.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/4.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuCell: UICollectionViewCell {

    //MARK: -定义属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- 系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}

extension AmuseMenuCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        //2.给cell设置数据
        cell.baseGame = groups![indexPath.item]
        cell.isHideBottomLine = true
        
        return cell
    }
}
