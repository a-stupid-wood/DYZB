//
//  UIImage+DYZB.swift
//  DouYuZB
//
//  Created by 王凯彬 on 2017/9/23.
//  Copyright © 2017年 WKB. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     返回一个UIImage 类方法
     
     - parameter color: 颜色
     - parameter size:  尺寸
     
     - returns: 一个UIImage
     */
    class func ImageWithColor(color:UIColor,size:CGSize)->UIImage
    {
        let rect = CGRect(origin: CGPoint(x: 0.0,y: 0.0), size: size)
        
        //开启一个图形上下文
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        //获取图形上下文
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        
        context!.fill(rect)
        
        //获取图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        UIGraphicsEndImageContext()
        
        return image!
        
    }
    
    /**
     返回一个UIImage 类方法
     
     - parameter color: 颜色
     
     - returns: 一个UIImage
     */
    class func imageFromColor(color:UIColor)->UIImage
    {
        let size = CGSize(width: 1.0, height: 1.0)
        return self.ImageWithColor(color: color, size: size)
    }
    
    /**
     返回一个UIImage
     
     - parameter tintColor: tintcolor
     
     - returns: 一个UIImage
     */
    func imageWithTintColor(tintColor:UIColor) -> UIImage
    {
        return self.imageWithTintColor(tintColor: tintColor, blendMode: .destinationIn)
    }
    
    /**
     返回一个UIImage
     
     - parameter tintColor: tintcolor
     
     - returns: 一个UIImage
     */
    func imageWithGrapdientTintColor(tintColor:UIColor) -> UIImage
    {
        return self.imageWithTintColor(tintColor: tintColor, blendMode: .overlay)
    }
    
    /**
     返回一个UIImage
     
     - parameter tintColor: tintColor
     - parameter blendMode: CGBlendMode
     
     - returns: 返回一个UIImage
     */
    func imageWithTintColor(tintColor:UIColor,blendMode:CGBlendMode) -> UIImage {
        //We want to keep alpha, set apaque to NO;Use 0.0 for sscale to use the scale factor of the device 's main screen
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        tintColor.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        
        //Draw the tinted image in context
        self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
        
        if blendMode != .destinationIn {
            self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        }
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage!
    }
    
    class func fixOrientation(aImage:UIImage)->UIImage
    {
        //NO-op if the orientation is already correct
        if aImage.imageOrientation == .up {
            return aImage
        }
        
        //We need to calculate the proper transformation to make the image upright.
        //We do it in 2 steps:Rotate if Left/Right/Down,and the flip if Mirrored.
        var transform = CGAffineTransform.identity
        
        
        switch aImage.imageOrientation {
        case .down,.downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left,.leftMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .right,.rightMirrored:
            transform = transform.translatedBy(x: 0, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2))
        default:
            break
        }
        
        switch aImage.imageOrientation {
        case .upMirrored,.downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored,.rightMirrored:
            transform = transform.translatedBy(x: aImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        //Now we draw the underlying CGImage into a new context,applying the transform calculate above
        let ctx = CGContext(data: nil, width: Int(aImage.size.width), height: Int(aImage.size.height),
                            bitsPerComponent: aImage.cgImage!.bitsPerComponent, bytesPerRow: 0,
                            space: aImage.cgImage!.colorSpace!,
                            bitmapInfo: aImage.cgImage!.bitmapInfo.rawValue)!
        
        ctx.concatenate(transform)
        switch aImage.imageOrientation {
        case .left,.leftMirrored,.right,.rightMirrored:
            //Grr....
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0,y: 0,width: aImage.size.height,height: aImage.size.width))
        default:
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0,y: 0,width: aImage.size.width,height: aImage.size.height))
        }
        //And now we just create a new UIImage from the drawing context
        let cgimg = ctx.makeImage()
        let img = UIImage(cgImage: cgimg!)
        
//        CGContextRelease(ctx);
//        CGImageRelease(cgimg);
        
        return img
    }
    
    //压缩图片
    func imageScale() -> UIImage {
        
        var imageSize = self.size;
        imageSize.height *= 0.4;
        imageSize.width *= 0.4;
        
        //Create a graphics image context
        UIGraphicsBeginImageContext(imageSize)
        
        //Tell the old image to draw in this new context,with the desired
        //new size
        self.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        //Get the new image from the context
        let newImage  = UIGraphicsGetImageFromCurrentImageContext()
        
        //End the context
        UIGraphicsEndImageContext()
        
        //Return a new image
        return newImage!
    }
    
}
