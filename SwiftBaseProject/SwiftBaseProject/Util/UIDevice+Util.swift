//
//  UIDevice+Util.swift
//  SwiftBaseProject
//
//  Created by 张永杰 on 2021/2/20.
//  Copyright © 2021 张永杰. All rights reserved.
//

import UIKit

extension UIDevice {

    public var isPad: Bool {
        return userInterfaceIdiom == .pad
    }
    
    public static func getCurrentLanguage() -> String {
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return "en"
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "cn"
        default:
            return "en"
        }
    }
    
}
