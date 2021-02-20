//
//  UITextField+Extension.swift
//  SwiftBaseProject
//
//  Created by 张永杰 on 2021/2/20.
//  Copyright © 2021 张永杰. All rights reserved.
//

import Foundation
import UIKit

extension UITextField { //move cursor
    func currentOffset() -> Int{
        return self.offset(from: beginningOfDocument, to: endOfDocument)
    }
    
    func makeOffset(offset: Int) {
        if let selectedRange = selectedTextRange {
            var currentOffset = self.offset(from: endOfDocument, to: selectedRange.end)
            currentOffset += offset
            if let newPostion = position(from: endOfDocument, offset: currentOffset){
                selectedTextRange = textRange(from: newPostion, to: newPostion)
            }
        }
    }
    
    func makeOffsetFromBeginning(offset: Int) {
        if let start = position(from: beginningOfDocument, offset: 0) {
            let range = textRange(from: start, to: start)
            selectedTextRange = range
            makeOffset(offset: offset)
        }
    }
    
    func addDoneTool() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(resignFirstResponder))
        toolbar.items = [spaceItem,doneItem]
        self.inputAccessoryView = toolbar
    }
    
}

// MARK: - Max Length
fileprivate var kAssociationKeyMaxLength: Int = 0

extension UITextField {

    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }

    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }

        let selection = selectedTextRange

        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)

        selectedTextRange = selection
    }
}
