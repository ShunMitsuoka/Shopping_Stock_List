//
//  Extension.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/25.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import Foundation
import UIKit

extension String{
    var localized: String
    {
        return NSLocalizedString(self, comment: self)
    }
}

extension UIImage {
    // resize image
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage! = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
}


