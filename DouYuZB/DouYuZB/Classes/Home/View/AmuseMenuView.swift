
//
//  AmuseMenuView.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/4.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    
    //MARK: -定义属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: -空间属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: 从xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "AmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let groups = self.groups else {
            return 0
        }
        
        let pageNum = (groups.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.去除cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuCell
        
        //2.给cell设置数据
        setUpCellData(withCell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    private func setUpCellData(withCell cell : AmuseMenuCell, indexPath : IndexPath){
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        cell.groups = Array(groups![startIndex...endIndex])
    }
}
