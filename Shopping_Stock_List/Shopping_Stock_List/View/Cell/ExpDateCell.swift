//
//  ExpDateCell.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class ExpDateCell: UITableViewCell,UITextFieldDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        //size設定
        self.frame = CGRect(x: 0, y: 0, width: ViewProperties.mainBoundSize.width, height: ViewProperties.cellHeight)
        backgroundColor = UIColor(red: 236/255, green: 230/255, blue: 229/255, alpha: 1)
        //textField設定
        DateField.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*0.9)
        DateField.placeholder = "賞味期限"
        DateField.font = UIFont.systemFont(ofSize:ViewProperties.mainBoundSize.width*0.6/8 )
        DateField.borderStyle = .none
        DateField.textAlignment = NSTextAlignment.center
        //delegate
        DateField.delegate = self
        //ピッカー設定
        datePicker.locale = Locale(identifier: "ja_JP")
        datePicker.datePickerMode = UIDatePicker.Mode.date
        //完了ボタンの作成
        let toolbar_Date = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem_Date = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done_Date))
        toolbar_Date.setItems([spacelItem, doneItem_Date], animated: true)
        
        DateField.inputView = datePicker
        DateField.inputAccessoryView = toolbar_Date
        
        self.addSubview(DateField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let DateField = UITextField()
    let datePicker = UIDatePicker()
    
    //    DatePickerのdoneボタンの動き
    @objc func done_Date() {
        DateField.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = NSTimeZone.local
        DateField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
