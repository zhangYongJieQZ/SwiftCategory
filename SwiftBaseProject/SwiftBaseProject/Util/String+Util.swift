//
//  String+Util.swift
//  SwiftBaseProject
//
//  Created by 张永杰 on 2021/2/20.
//  Copyright © 2021 张永杰. All rights reserved.
//

import Foundation
public extension String {

    func containsIgnoringCase(find: String) -> Bool {
        return range(of: find, options: .caseInsensitive) != nil
    }

    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }

    func validatePhone() -> Bool {
        let phoneRegex: String = "^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\\s\\./0-9]{6,}$"
        let phoneTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }

    func retainNumericCharacters() -> String {
        let stringArray = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
        return stringArray.joined(separator: "")
    }
    
    func validateUrl() -> Bool {
        let urlRegex: String = "(?i:http|https|rtsp|ftp)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"
        let urlTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        return urlTest.evaluate(with: self)
    }

    func couldAt(range: NSRange) -> Bool {
        if range.location <= 0 { return true }
        let lastChar = self.substring(to: range.location).last!
        return !(lastChar.isLetter || lastChar.isNumber)
    }

}

// MARK: - 字符串截取
extension String {
    /// String使用下标截取字符串
    /// string[index] 例如："abcdefg"[3] // c
    subscript (i:Int) -> String {
        let startIndex = utf16.index(self.startIndex, offsetBy: i)
        let endIndex = utf16.index(startIndex, offsetBy: 1)
        return String(self[startIndex..<endIndex])
    }
    
    /// String使用下标截取字符串
    /// string[index..<index] 例如："abcdefg"[3..<4] // d
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = utf16.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = utf16.index(startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    /// String使用下标截取字符串
    /// string[index,length] 例如："abcdefg"[3,2] // de
    subscript (index:Int , length:Int) -> String {
        get {
            let startIndex = utf16.index(self.startIndex, offsetBy: index)
            let endIndex = utf16.index(startIndex, offsetBy: length)
            return String(self[startIndex..<endIndex])
        }
    }
    
    // 截取 从头到i位置
    func substring(to:Int) -> String {
        let endIndex = utf16.index(startIndex, offsetBy: to)
        return String(self[startIndex..<endIndex])
    }
    
    // 截取 从i到尾部
    func substring(from:Int) -> String {
        let startIndex = utf16.index(self.startIndex, offsetBy: from)
        return String(self[startIndex..<endIndex])
    }
    
}


public extension String {
    var md5: String {
        guard let data = data(using: .utf8) else {
            return self
        }
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        #if swift(>=5.0)
        _ = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        #else
        _ = data.withUnsafeBytes { bytes in
            return CC_MD5(bytes, CC_LONG(data.count), &digest)
        }
        #endif
        
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
