//
//  Category_image_cell.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class Category_Image_cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect(x: 0, y: 0, width: ViewProperties.mainBoundSize.width, height: ViewProperties.cellHeight*3)
        self.backgroundColor = UIColor(red: 225/255, green: 200/255, blue: 168/255, alpha: 1)
        
        //categoryView追加
        
        //imageview追加
        categoryView = CategoryView()
        imageview = imageViewForCell()
        self.addSubview(imageview!)
        self.addSubview(categoryView!)
        
        self.selectionStyle = .none
        
    }
    
    var categoryView:CategoryView?
    var imageview:imageViewForCell?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
