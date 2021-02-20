//
//  ViewEntrance.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import Foundation
import UIKit

func showSheetView(title:String,message:String,actionArray:[String], viewController:UIViewController, succeed:@escaping(Any?) -> (), failure : @escaping(Any?) -> ()){
    let actionSheet = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
    for i in 0...(actionArray.count - 1){
        let title = actionArray[i]
        let action = UIAlertAction.init(title: title, style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            succeed(i)
        });
        actionSheet.addAction(action)
    }
    let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
        failure("取消")
        actionSheet.dismiss(animated: true, completion: nil)
    }
    actionSheet.addAction(cancelAction)
    viewController.present(actionSheet, animated: true, completion: nil)
}

func showAlertCancelView(title:String, message:String, viewController:UIViewController) -> () {
    let actionSheet = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
        actionSheet.dismiss(animated: true, completion: nil)
    }
    actionSheet.addAction(cancelAction)
    viewController.present(actionSheet, animated: true, completion: nil)
}

func showAlertSureView(title:String, message:String, viewController:UIViewController) -> () {
    let actionSheet = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let cancelAction = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
        actionSheet.dismiss(animated: true, completion: nil)
    }
    actionSheet.addAction(cancelAction)
    viewController.present(actionSheet, animated: true, completion: nil)
}

func showAlertView(title:String, message:String!, viewController:UIViewController,sureAction:@escaping() -> (), cancelAction : @escaping() -> ()){
    let actionSheet = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let cancelActionS = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
        cancelAction()
        actionSheet.dismiss(animated: true, completion: nil)
    }
    actionSheet.addAction(cancelActionS)
    
    let sureActionS = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default) { (UIAlertAction) in
        sureAction()
        actionSheet.dismiss(animated: true, completion: nil)
    }
    actionSheet.addAction(sureActionS)
    viewController.present(actionSheet, animated: true, completion: nil)
}
