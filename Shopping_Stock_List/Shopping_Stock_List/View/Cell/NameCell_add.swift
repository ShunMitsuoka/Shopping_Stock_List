//
//  NameCell_add.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class NameCell_add: SuperNameCell,UITextFieldDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        //textField設定
        textField.delegate = self
        
        textField.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*0.9)
        textField.placeholder = "食材名"
        textField.font = UIFont.systemFont(ofSize:ViewProperties.mainBoundSize.width*0.6/8 )
        textField.borderStyle = .none
        textField.textAlignment = NSTextAlignment.center
        
        //完了ボタンの作成
        let toolbar_Done = ViewProperties.setToolbar_Done(view:self, action: #selector(done_Date))
        textField.inputAccessoryView = toolbar_Done
        
        self.addSubview(textField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textField = UITextField()
    
    //    textFieldのdoneボタンの動き
    @objc func done_Date() {
        textField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
