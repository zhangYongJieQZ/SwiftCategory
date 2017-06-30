//
//  YJConfigure.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import Foundation
import UIKit
import Security

class Configure: NSObject {
    class func saveValue(key:String!, value:Any) -> () {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getValue(key:String!) -> Any {
        return UserDefaults.standard.value(forKey: key) ?? ""
    }
    
    class func removeValue(key:String!) -> () {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func calcateWidth(str:String!,font:UIFont!) -> CGFloat{
        let statusText:NSString = str as NSString
        let attributes = [NSFontAttributeName:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = statusText.boundingRect(with: CGSize.init(width: screenWidth, height: 999), options: option, attributes: attributes, context: nil);
        let width = rect.size.width + 2;
        return width
    }
    
}
