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
        datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        DateField.inputView = datePicker
        //完了ボタンの作成
        let toolbar_Done = ViewProperties.setToolbar_Done_ForDate(view:self, doneAction: #selector(done_Date),cancelAction: #selector(cancel_Date))
        DateField.inputAccessoryView = toolbar_Done

        self.addSubview(DateField)
        self.date = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let DateField = UITextField()
    let datePicker = UIDatePicker()
    var date:String?
    
    //    DatePickerのdoneボタンの動き
    @objc func done_Date() {
        DateField.endEditing(true)
        // 日付の入力
        DateField.text = ViewProperties.DateFormmat(date: datePicker.date)
        date = ViewProperties.DateFormmat(date: datePicker.date)
    }
    
    
    //    DatePickerのcancelボタンの動き
    @objc func cancel_Date() {
        DateField.endEditing(true)
        // 日付の入力
        DateField.text = ""
        date = nil
    }
    
    //DatePickerの値が変化した際の動き
    @objc func didDatePickerValueChanged(_ sender : UIDatePicker){
        DateField.text = ViewProperties.DateFormmat(date: datePicker.date)
        date = ViewProperties.DateFormmat(date: datePicker.date)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

}
