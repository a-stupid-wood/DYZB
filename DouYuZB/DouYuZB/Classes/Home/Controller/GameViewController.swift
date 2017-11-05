
//
//  GameViewController.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/3.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenWidth - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: BaseViewController {
    
    //MARK: 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenWidth, height: kHeaderViewH)
        headerView.titleLabel.text = "常用"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        return gameView
    }()

    //MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        //请求数据
        loadData()
    }
}

//MARK:-设置UI界面
extension GameViewController {
    override func setupUI() {
        //0.给父类的contentView赋值
        contentView = collectionView
        
        //1.添加UICollectionView
        view.addSubview(collectionView)
        
        //2.添加顶部的HeaderView
        collectionView.addSubview(topHeaderView)
        
        //3.将常用游戏的view，添加到CollectionView中
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        super.setupUI()
    }
}

//MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            //1.展示我们的全部游戏
            self.collectionView.reloadData()
            
            //2.展示我们的常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
            
            //3.数据请求完成
            self.loadDataFinished()
        }
    }
}

//MARK:- 遵守UICollectionViewDataSource协议
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = gameVM.games[indexPath.item]
        cell.isHideBottomLine = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.获取headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.给HeaderView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}
