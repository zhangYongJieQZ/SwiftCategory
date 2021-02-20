//
//  Optional+Numeric.swift
//  SwiftBaseProject
//
//  Created by 张永杰 on 2021/2/20.
//  Copyright © 2021 张永杰. All rights reserved.
//

import Foundation

public extension Optional where Wrapped: AdditiveArithmetic {
    static func + (left: Optional, right: Optional) -> Optional {
        guard let left = left else {
            return right
        }
        
        guard let right = right else {
            return left
        }
        
        return left + right
    }
}
