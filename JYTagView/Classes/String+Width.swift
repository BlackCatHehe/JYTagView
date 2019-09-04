//
//  String+Width.swift
//  TestSwiftKeyChain
//
//  Created by APP on 2019/8/30.
//  Copyright © 2019 APP. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    public func jy_getSizeWith(font: UIFont, maxSize: CGSize) ->CGSize{
        
        let size = (self as NSString).boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
        return size
    }
}
