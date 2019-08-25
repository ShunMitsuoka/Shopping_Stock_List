//
//  MemoCell.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/19.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell,UITextViewDelegate{

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        //cell自身のサイズ
        let navi = MyUINavigationController()
        let tab = MyUITabBarController()
        let tableViewHeight = ViewProperties.mainBoundSize.height - navi.navigationHeight() - tab.tabBarHeight()
        let textFieldHeight = tableViewHeight - ViewProperties.cellHeight*7
        self.frame = CGRect(x: 0, y: 0, width: ViewProperties.mainBoundSize.width, height: textFieldHeight)
        textView.delegate = self
        //textViewの設定
        textView.frame = self.frame
        textView.backgroundColor = UIColor(red: 225/255, green: 200/255, blue: 168/255, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.isEditable = true
        
        //完了ボタンの作成
        let toolbar_Done = ViewProperties.setToolbar_Done(view:self, action: #selector(done_Date))
        textView.inputAccessoryView = toolbar_Done
        
        self.addSubview(textView)
        
        //Cell設定
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textView = UITextView()
    
    //    textFieldのdoneボタンの動き
    @objc func done_Date() {
        textView.endEditing(true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.endEditing(true)
        setSelected(false, animated: false)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        setSelected(true, animated: false)
        return true
    }

}
