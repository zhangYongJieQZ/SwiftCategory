//
//  ViewControllerExtension.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import UIKit
let navLeftBtnTag = 1220
let navRightBtnTag = 1230

extension UIViewController{
    func createNavBackButton() -> () {
        let backBtn = UIButton.init(type: UIButtonType.custom)
        backBtn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 40)
        backBtn.addTarget(self, action: #selector(UIViewController.backAction), for: UIControlEvents.touchUpInside)
        backBtn.setImage(UIImage.init(named: "left-arrow"), for: UIControlState.normal)
        let cancelButtonItem = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.leftBarButtonItem = cancelButtonItem
    }
    
    func createBlackNavBackButton() -> () {
        let backBtn = UIButton.init(type: UIButtonType.custom)
        backBtn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        backBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -15, bottom: 0, right: 0)
        backBtn.addTarget(self, action: #selector(UIViewController.backAction), for: UIControlEvents.touchUpInside)
        backBtn.setImage(UIImage.init(named: "left-arrow01"), for: UIControlState.normal)
        let cancelButtonItem = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.leftBarButtonItem = cancelButtonItem
    }
    
    func createRightButton() -> () {
        let rightBtn = UIButton.init(type: UIButtonType.custom)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: 32, height: 32)
        rightBtn.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        rightBtn.addTarget(self, action: #selector(UIViewController.rightAction), for: UIControlEvents.touchUpInside)
        rightBtn.setImage(UIImage.init(named: "icon_usercenter"), for: UIControlState.normal)
        let rightButtonItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func createRightButton(title:String) -> () {
        let rightBtn = UIButton.init(type: UIButtonType.custom)
        rightBtn.tag = 10086
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: 50, height: 32)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        rightBtn.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        rightBtn.addTarget(self, action: #selector(UIViewController.rightAction), for: UIControlEvents.touchUpInside)
        rightBtn.setTitle(title, for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        let rightButtonItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func createNavLeftButtons(leftImageAry:[String]) -> () {
        var items:[UIBarButtonItem] = []
        for index in 1...leftImageAry.count {
            let leftBtn = UIButton.init(type: UIButtonType.custom)
            leftBtn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
            leftBtn.setImage(UIImage.init(named: leftImageAry[index-1]), for: UIControlState.normal)
            leftBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -21, bottom: 0, right: 0)
            leftBtn.addTarget(self, action: #selector(UIViewController.leftActions(leftButton:)), for:UIControlEvents.touchUpInside)
            leftBtn.tag = navLeftBtnTag + index
            let leftItem = UIBarButtonItem.init(customView: leftBtn)
            items.append(leftItem)
        }
        if items.count == 1 {
            self.navigationItem.leftBarButtonItem = items.first
        }else{
            self.navigationItem.leftBarButtonItems = items
        }
    }
    
    func createNavRightButtons(rightImageAry:[String]) -> () {
        var items:[UIBarButtonItem] = []
        for index in 1...rightImageAry.count {
            let rightBtn = UIButton.init(type: UIButtonType.custom)
            rightBtn.frame = CGRect.init(x: 31, y: (44-19)/2, width: 19, height: 19)
            rightBtn.setImage(UIImage.init(named: rightImageAry[index-1]), for: UIControlState.normal)
            rightBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -21, bottom: 0, right: 0)
            rightBtn.addTarget(self, action: #selector(UIViewController.rightActions(rightButton:)), for:UIControlEvents.touchUpInside)
            rightBtn.tag = navRightBtnTag + index
            let leftItem = UIBarButtonItem.init(customView: rightBtn)
            items.append(leftItem)
        }
        if items.count == 1 {
            self.navigationItem.rightBarButtonItem = items.first
        }else{
            self.navigationItem.rightBarButtonItems = items
        }
    }
    
    func leftActions(leftButton:UIButton) -> () {
        
    }
    
    func rightActions(rightButton:UIButton) -> () {
        
    }
    
    func rightAction() -> () {
        print("rightAction")
    }
    
    func backAction() -> () {
        if self.navigationController?.viewControllers.count == 1 {
            self.dismiss(animated: true, completion: nil)
        }else{
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
