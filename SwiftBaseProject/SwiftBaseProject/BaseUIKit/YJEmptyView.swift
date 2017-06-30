//
//  YJEmptyView.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import UIKit

class YJEmptyView: UIView {
    private var iconImage:UIImageView?
    private var titleLabel:UILabel?
    init(frame: CGRect, imageName:String, titleName:String) {
        super.init(frame: frame)
        if imageName.isEmpty == false{
            let icon = UIImage.init(named: imageName)
            iconImage = UIImageView.init(frame: CGRect.init(x: (frame.size.width - (icon?.size.width)!)/2, y: 100, width: (icon?.size.width)!, height: (icon?.size.height)!))
            iconImage?.image = icon
            self.addSubview(iconImage!)
        }
        if titleName.isEmpty == false{
            titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: (iconImage?.bottom())! + 10, width: frame.size.width, height: 40))
            titleLabel?.text = titleName
            titleLabel?.textAlignment = NSTextAlignment.center
            titleLabel?.font = UIFont.systemFont(ofSize: 45/2.88)
            self.addSubview(titleLabel!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

