//
//  UIImageExtension.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import UIKit

extension UIImage{
    class func generateBarCode(code:String,size:CGSize,color:UIColor?,backgroundColor:UIColor?)->(UIImage) {
        let data = code.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        let filter = CIFilter.init(name: "CICode128BarcodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        let colorFilter = CIFilter.init(name: "CIFalseColor")
        colorFilter?.setValue(filter?.outputImage, forKey: "inputImage")
        if color == nil {
            colorFilter?.setValue(CIColor.init(cgColor: UIColor.black.cgColor), forKey: "inputColor0")
        }else{
            colorFilter?.setValue(CIColor.init(cgColor: (color?.cgColor)!), forKey: "inputColor0")
        }
        if backgroundColor == nil {
            colorFilter?.setValue(CIColor.init(cgColor: UIColor.white.cgColor), forKey: "inputColor1")
        }else{
            colorFilter?.setValue(CIColor.init(cgColor: (backgroundColor?.cgColor)!), forKey: "inputColor1")
        }
        let barcodeImage = colorFilter?.outputImage
        let scaleX = size.width / (barcodeImage?.extent.size.width)!
        let scaleY = size.height / (barcodeImage?.extent.size.height)!
        let transformedImage = barcodeImage?.applying(CGAffineTransform.init(scaleX: scaleX, y: scaleY))
        return UIImage.init(cgImage: transformedImage as! CGImage)
    }
    
    class func QRCode(code:String)->(UIImage) {
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        let data = code.data(using: String.Encoding.utf8)
        filter?.setValue(data, forKey: "inputMessage")
        let outputImage = filter?.outputImage
        return UIImage.init(ciImage: outputImage!, scale: 20.0, orientation: UIImageOrientation.up)
    }
}
