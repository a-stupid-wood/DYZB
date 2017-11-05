//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/4.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalHeaderID = "kNormalHeaderID"

let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenWidth - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

class BaseAnchorViewController: BaseViewController {
    
    //MARK:- 懒加载属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kNormalHeaderID)
        
        return collectionView
        }()
    
    //MARK: 定义属性
    var baseVM : BaseViewModel!

    //MARK:-系统回调u
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }
}

//MARK:- 设置UI界面
extension BaseAnchorViewController {
    override func setupUI() {
        //1.给父类中内容的view的引用进行赋值
        contentView = collectionView
        
        //2.添加collectionView
        view.addSubview(collectionView)
        
        //3.调用super的setupUI()
        super.setupUI()
        
    }
}

//MARK:- 请求数据
extension BaseAnchorViewController {
    func loadData() {
        
    }
}

//MARK: -遵守UICollectionViewDataSource协议
extension BaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        //给cell设置数据
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeaderID, for: indexPath) as! CollectionHeaderView
        
        //2.给HeaderView设置数据
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}

//MARK:- 遵守UICollectionViewDelegateFlowLayout
extension BaseAnchorViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.取出对应的主播的信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        //2.判断是秀场房间&普通房间
        anchor.isVertical == 1 ? presentShowRoomVC() : pushNormalRoomVC()
    }
    
    private func presentShowRoomVC() {
        //1.创建showRoomVC
        let showRoomVC = RoomShowViewController()
        
        //2.以Modal方式弹出
        present(showRoomVC, animated: true, completion: nil)
    }
    
    private func pushNormalRoomVC() {
        //1.创建NormalRoomVC
        let normalRoomVC = RoomNormalViewController()
        
        //2.以push的方式弹出
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }
}

