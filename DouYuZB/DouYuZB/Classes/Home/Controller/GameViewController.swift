
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

private let kGameCellID = "kGameCellID"

class GameViewController: UIViewController {
    
    //MARK: 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        return collectionView
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
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

//MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
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
}
