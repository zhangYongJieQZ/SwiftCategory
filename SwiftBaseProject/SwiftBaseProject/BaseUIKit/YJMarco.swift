//
//  YJMarco.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import Foundation
import UIKit
//自定义存储字段
let userToken = "user_token"
let userId = "id"

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

let mainStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)

let kAppdelegate = (UIApplication.shared.delegate) as! AppDelegate

func widthRace(x:CGFloat) -> CGFloat {
    return x * screenWidth / 320.0
}

func kip6WidthRace(x:CGFloat) -> CGFloat{
    return x * screenWidth / 375.0
}

func getUserToken()->(Any){
    return UserDefaults.standard.object(forKey: userToken) ?? ""
}

func getUserId()->(Any){
    return UserDefaults.standard.object(forKey: userId) ?? ""
}
//屏幕有旋转的情况下，取这个值才是准确的
func mainScreenWidth()->(CGFloat){
    return UIScreen.main.bounds.size.width
}

func mainScreenHeight()->(CGFloat){
    return UIScreen.main.bounds.size.height
}

func getHeightFromAttributedString(textString:String,font:UIFont,spacing:NSInteger)->(CGFloat){
    let str = NSString.init(string: textString)
    let paraStyle = NSMutableParagraphStyle.init()
    paraStyle.lineSpacing = 10
    let contentSize = str.boundingRect(with: CGSize.init(width: mainScreenWidth() - CGFloat(spacing * 2), height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle], context: nil)
    return contentSize.height
}
