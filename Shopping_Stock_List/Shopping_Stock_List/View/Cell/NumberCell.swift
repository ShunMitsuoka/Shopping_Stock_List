//
//  NumberCell.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/19.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class NumberCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        //Cellサイズ設定
        self.frame = CGRect(x: 0, y: 0, width: ViewProperties.mainBoundSize.width, height: ViewProperties.cellHeight)
        self.backgroundColor = UIColor(red: 236/255, green: 230/255, blue: 229/255, alpha: 1)
        
        //textField設定
        NumberField.frame = self.bounds
        NumberField.placeholder = "個数"
        NumberField.font = UIFont.systemFont(ofSize:ViewProperties.mainBoundSize.width*0.6/8 )
        NumberField.borderStyle = .none
        NumberField.textAlignment = NSTextAlignment.center
        NumberField.keyboardType = .numberPad
        
        //完了ボタンの作成
        let toolbar_Done = ViewProperties.setToolbar_Done(view:self, action: #selector(done_Date))
        NumberField.inputAccessoryView = toolbar_Done
        
        self.addSubview(NumberField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let NumberField = UITextField()
    
    //    NumberFieldのdoneボタンの動き
    @objc func done_Date() {
        NumberField.endEditing(true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
