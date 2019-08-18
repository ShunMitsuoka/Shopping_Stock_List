//
//  imageViewForCell.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class imageViewForCell: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: ViewProperties.mainBoundSize.width*0.6, y: 0, width: ViewProperties.mainBoundSize.width*0.4, height: ViewProperties.cellHeight*3)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
