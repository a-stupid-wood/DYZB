//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/11/4.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - 定义属性
    var contentView : UIView?
    
    //MARK: 懒加载属性
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1_160x180_"))
        imageView.center = self.view.center
        var animationImages = [UIImage]()
        for i in 1...4 {
            animationImages.append(UIImage(named: "img_loading_\(i)_160x180_")!)
        }
        imageView.animationImages = animationImages
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()

    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension BaseViewController {
    func setupUI() {
        //1.隐藏内容的View
        contentView?.isHidden = true
        
        //2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        
        //3.给animImageView执行动画
        animImageView.startAnimating()
        
        //4.设置view的backgroundColor
        view.backgroundColor = UIColor.commonColor(red: 250, green: 250, blue: 250)
    }
    
    func loadDataFinished() {
        //1.停止动画
        animImageView.stopAnimating()
        
        //2.隐藏animImageView
        animImageView.isHidden = true
        
        //3.显示内容的View
        contentView?.isHidden = false
    }
}
