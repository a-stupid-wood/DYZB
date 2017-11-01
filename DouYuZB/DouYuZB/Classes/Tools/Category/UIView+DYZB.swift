//
//  UIView+DYZB.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

extension UIView{
    
    var kLeft:CGFloat{
        get{
            return self.frame.origin.x
        }set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var kTop:CGFloat{
        get{
            return self.frame.origin.y
        }set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var kRight:CGFloat{
        get{
            return self.frame.origin.x + self.frame.size.width
        }set{
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    var kBottom:CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }set{
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    var kWidth:CGFloat{
        get{
            return self.frame.size.width
        }set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var kHeight:CGFloat{
        get{
            return self.frame.height
        }set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var kCenterX:CGFloat{
        get{
            return self.center.x
        }set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    var kCenterY:CGFloat{
        get{
            return self.center.y
        }set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    var kOrigin:CGPoint{
        get{
            return self.frame.origin
        }set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var kSize:CGSize{
        get{
            return self.frame.size
        }set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    //创建一张纯色图片
    func pureColorImage(color:UIColor)->UIImage{
        let imageSize = self.frame.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        color.set()
        UIRectFill(CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let pureColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return pureColorImage!
    }
    
    //截图
    func snapshotImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return snap!
    }
    
    
}

