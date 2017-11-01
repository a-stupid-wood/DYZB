//
//  UIBarbuttonItem+DYZB.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

enum BarbuttonPosition {
    case left
    case right
}

class BarButtonView: UIView {
    var position : BarbuttonPosition = .left
    private var applied : Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if applied || kSystemVersion < 11  {
            return
        }
        
        var view : UIView = self
        while !view.isKind(of: UINavigationBar.self) && view.superview != nil{
            view = view.superview!
            if view.isKind(of: UIStackView.self) && view.superview != nil{
                if position == .left {
                    view.superview?.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: view.superview!, attribute: .leading, multiplier: 1.0, constant: 2.0))
                    applied = true
                }else if position == .right {
                    view.superview?.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: view.superview!, attribute: .trailing, multiplier: 1.0, constant: -8.0))
                    applied = true
                }
                break
            }
            
            
        }
    }
}

extension UIBarButtonItem {
    class func barbuttonItems(customViews:[UIView],position : BarbuttonPosition) -> [UIBarButtonItem] {
        var barButtonItems = [UIBarButtonItem]()
        var customView : UIView
        for i in 0 ..< customViews.count {
            let view = customViews[i]
            if kSystemVersion < 11 {
                customView = view;
            }else{
                let barButtonView = BarButtonView(frame: view.frame)
                barButtonView.position = position
                barButtonView.addSubview(view)
                customView = barButtonView;
            }
            let barButtonItem = UIBarButtonItem(customView: customView)
            barButtonItems.append(barButtonItem);
        }
        if kSystemVersion < 11  {
            let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            spaceItem.width = position == .left ? -15.0 : -8.0;
            barButtonItems.insert(spaceItem, at: 0)
        }
        return barButtonItems
    }
}

