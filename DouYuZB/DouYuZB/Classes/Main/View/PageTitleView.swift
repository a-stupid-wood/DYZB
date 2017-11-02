//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/25.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

//MARK:-定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int)
}

//MARK:-定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

//MARK:-定义PageTitleView类
class PageTitleView: UIView {
    
    //MARK:定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    //MARK:懒加载属性
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()

    //MARK:自定义构造函数
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: 设置UI界面
extension PageTitleView {
    
    fileprivate func setupUI() {
        //添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加title对应的label
        setupTitleLabels()
        
        //设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        //0.确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.commonColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            if #available(iOS 11.0, *) {
                scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
            } else {
                // Fallback on earlier versions
            }
            titleLabels.append(label)
            
            //5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1.获取第一个label
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.commonColor(red: kSelectColor.0, green: kSelectColor.1, blue: kSelectColor.2)
        
        //2.2.设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK: - 监听Label的点击
extension PageTitleView {
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer) {
        //0.获取点前label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        //1.如果是重复点击同一个Title，那么直接返回
        if currentLabel.tag == currentIndex {return}
        
        //2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字的颜色
        currentLabel.textColor = UIColor.commonColor(red: kSelectColor.0, green: kSelectColor.1, blue: kSelectColor.2)
        oldLabel.textColor = UIColor.commonColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
        
        //4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

//MARK:-对外暴露的方法
extension PageTitleView {
    func setTitle(progress : CGFloat ,sourceIndex : Int, targetIndex : Int) {
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex];
        let targetLabel = titleLabels[targetIndex];
        
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色的渐变
        //3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        //3.2.变化sourceLabel
        sourceLabel.textColor = UIColor.commonColor(red: kSelectColor.0 - colorDelta.0 * progress, green: kSelectColor.1 - colorDelta.1 * progress, blue: kSelectColor.2 - colorDelta.2 * progress)
        
        //3.3.变化targetLabel
        targetLabel.textColor = UIColor.commonColor(red: kNormalColor.0 + colorDelta.0 * progress, green: kNormalColor.1 + colorDelta.1 * progress, blue: kNormalColor.2 + colorDelta.2 * progress)
        
        //4.记录最新的index
        currentIndex = targetIndex
        
    }
}
