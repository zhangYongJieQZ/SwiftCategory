//
//  YJColor.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import Foundation
import UIKit

func RGBCOLOR(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red:(r)/255.0,green:(g)/255.0,blue:(b)/255.0,alpha:(1.0))
}

func HEXCOLOR(hex:String) -> UIColor {
    var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        let index = cString.index(cString.startIndex, offsetBy:1)
        cString = cString.substring(from: index)
    }
    
    if (cString.characters.count != 6) {
        return UIColor.red
    }
    
    let rIndex = cString.index(cString.startIndex, offsetBy: 2)
    let rString = cString.substring(to: rIndex)
    let otherString = cString.substring(from: rIndex)
    let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
    let gString = otherString.substring(to: gIndex)
    let bIndex = cString.index(cString.endIndex, offsetBy: -2)
    let bString = cString.substring(from: bIndex)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}
//测试视图用
func redLayer(view:UIView) -> () {
    view.layer.borderWidth = 1.0
    view.layer.borderColor = UIColor.red.cgColor
}

func blueLayer(view:UIView) -> () {
    view.layer.borderWidth = 1.0
    view.layer.borderColor = UIColor.blue.cgColor
}

func grayLayer(view:UIView) -> () {
    view.layer.borderWidth = 1.0
    view.layer.borderColor = UIColor.gray.cgColor
}

func blackLayer(view:UIView) -> () {
    view.layer.borderWidth = 1.0
    view.layer.borderColor = UIColor.black.cgColor
}
