//
//  ViewExtension.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import UIKit

extension UIView {
    func left() -> CGFloat {
        return self.frame.origin.x
    }
    func top() -> CGFloat {
        return self.frame.origin.y
    }
    func right() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    func bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    func width() -> CGFloat {
        return self.frame.size.width
    }
    func height() -> CGFloat {
        return self.frame.size.height
    }
    func centerX() -> CGFloat {
        return (self.frame.origin.x + self.frame.size.width) / 2
    }
    func centerY() -> CGFloat {
        return (self.frame.origin.y + self.frame.size.height) / 2
    }
    
    func radius(radius:CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
}
