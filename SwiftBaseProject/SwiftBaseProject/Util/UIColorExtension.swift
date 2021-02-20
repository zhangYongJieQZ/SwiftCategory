//
//  YJColor.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//
import UIKit

extension UIColor {
    public convenience init(hex: Int) {
        self.init(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(hex & 0xFF)) / 255.0,
                   alpha: 1.0)
    }
    
    static func fromRGB(r: Int, g: Int, b: Int) -> UIColor {
        return UIColor.fromRGBA(r: r, g: g, b: b, a: 1.0)
    }

    static func fromRGBA(r: Int, g: Int, b: Int, a: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
}

