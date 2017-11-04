//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    //MARK:懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kNavAndStatusBarHeight, width: kScreenWidth, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        //1.确定内容的frame
        let contentH = kScreenHeight - kStatusBarHeight - kNavHeight - kTitleViewH - kTabBarHeight
        let contentFrame = CGRect(x: 0, y: kStatusBarHeight + kNavHeight + kTitleViewH, width: kScreenWidth, height: contentH)
        
        //2.确定所有的子控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(AmuseViewController())
        childVCs.append(FunnyViewController())
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .orange
    }
}

//MARK:- 设置UI界面
extension HomeViewController : UITextFieldDelegate {
    
    fileprivate func setupUI() {
        //1.设置导航栏
        setupNavigationBar()
        
        //2，添加TitleView
        view.addSubview(pageTitleView)
        
        if #available(iOS 11.0, *) {} else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        //3.添加ContentView
        view.addSubview(pageContentView)
    }
    
    //MARK:设置导航栏
    private func setupNavigationBar() {
        //设置左边的Item
        let logoBtn = UIButton()
        logoBtn.setImage(UIImage(named:"homeLogoIcon_61x29_"), for: .normal)
        logoBtn.sizeToFit()

        navigationItem.leftBarButtonItems = UIBarButtonItem.barbuttonItems(customViews: [logoBtn],position:.left)
        
        //设置右边的Item
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named:"viewHistoryIcon_24x24_"), for: .normal)
        historyBtn.setImage(UIImage(named:"viewHistoryIconHL_24x24_"), for: .highlighted)
        historyBtn.sizeToFit()
        
        let gameCenterBtn = UIButton()
        gameCenterBtn.setImage(UIImage(named:"home_newGameicon_24x24_"), for: .normal)
        gameCenterBtn.setImage(UIImage(named:"home_newGameicon_clicked_24x24_"), for: .highlighted)
        gameCenterBtn.sizeToFit()
        
        navigationItem.rightBarButtonItems = UIBarButtonItem.barbuttonItems(customViews: [historyBtn,gameCenterBtn],position:.right)
        
        //设置中间的titleView
        navigationItem.titleView = createNavTitleView();
    }
    
    private func createNavTitleView() -> UIView {
        let textFieldH : CGFloat = 30.0
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: DYZB_RealWidth(width: 200), height: textFieldH))
        
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: titleView.frame.width, height: textFieldH))
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 14;
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = UIColor.commonColor(red: 176, green: 176, blue: 176)
        textField.adjustsFontSizeToFitWidth = true //当文字超出文本框宽度时,自动调整文字大小
        textField.minimumFontSize = 12 //最小可缩小的字号
        textField.text = "斗鱼直播"
        titleView.addSubview(textField);
        
        //设置搜索框左边的Icon
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldH, height: textFieldH))
        
        let leftIconView = UIImageView(frame: CGRect(x: 8, y: 8, width: 14, height: 14))
        leftIconView.image = UIImage(named:"home_newSeacrhcon_13x13_")
        leftIconView.contentMode = .scaleAspectFit
        leftView.addSubview(leftIconView)
        
        textField.leftView = leftView;
        textField.leftViewMode = .always
        
        //设置搜索框右边扫描二维码Icon
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldH, height: textFieldH))
        
        let rightIconView = UIButton(type: .custom);
        rightIconView.setImage(UIImage(named:"home_newSaoicon_24x24_"), for: .normal)
        rightIconView.frame = CGRect(x: 0, y: 3, width: 24, height: 24)
        rightIconView.contentMode = .scaleAspectFit
        rightView.addSubview(rightIconView);
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        return titleView
    }
    
    //MARK:UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

//MARK:-遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurentIndex(currentIndex: index)
    }
}

//MARK:-遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

