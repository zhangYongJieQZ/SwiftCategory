//
//  UIViewController+Alert.swift
//  SwiftBaseProject
//
//  Created by 张永杰 on 2021/2/20.
//  Copyright © 2021 张永杰. All rights reserved.
//

import UIKit

extension UIViewController {
    public func presentAlert(title: String?, message: String? = nil, buttonTitle: String? = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .cancel) { (a) in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    public func presentAlertTwoButton(title: String?,
                                      message: String? = nil,
                                      button1Title: String? = "OK",
                                      button2Title: String? = "Cancel",
                                      action: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: button1Title, style: .default){ _ in
            action()
        }
        
        let action2 = UIAlertAction(title: button2Title, style: .cancel) { (a) in
            alert.dismiss(animated: true)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
}
