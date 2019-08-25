//
//  SuperVC_StockDetails.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/24.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class SuperVC_StockDetails: SuperViewController_Details {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //cellの登録
        self.tableView.register(NameCell_add.self, forCellReuseIdentifier: "NameCell")
        self.tableView.register(ExpDateCell.self, forCellReuseIdentifier: "ExpDateCell")
        self.tableView.register(Category_Image_cell.self, forCellReuseIdentifier: "Cate_Img_Cell")
        self.tableView.register(NumberCell.self, forCellReuseIdentifier: "NumberCell")
        self.tableView.register(AmountCell.self, forCellReuseIdentifier: "AmountCell")
        self.tableView.register(MemoCell.self, forCellReuseIdentifier: "MemoCell")
    }
    
    
    //keyboard出てきた時
    override func keyBoardWillShow(notification:Notification?){
        if self.memoCell!.isSelected {
            //Keyboardの高さ取得
            let rect = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duraion:TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: duraion!, animations: { () in
                //tableViewscrollをoff
                self.tableView.isScrollEnabled = false
                //tableview高さ取得
                let keyboardHeight = (rect?.size.height)!
                //tableviewを一番下に移動
                let hiddenpartHeight = self.tableView.contentSize.height - self.tableView.frame.size.height
                self.tableView.contentOffset.y = hiddenpartHeight + keyboardHeight
                
                print(self.memoCell!)
            })
        }
    }
    
    //keyboard消えた時
    override func keyBoardWiiHide(notification:Notification?){
        self.tableView.contentOffset.y = 0
        //tableViewscrollをon
        self.tableView.isScrollEnabled = true
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.nameCell_add = (tableView.dequeueReusableCell(withIdentifier: "NameCell") as! NameCell_add)
                return self.nameCell_add!
            case 1:
                self.expDateCell = (tableView.dequeueReusableCell(withIdentifier: "ExpDateCell") as! ExpDateCell)
                return self.expDateCell!
            case 2:
                self.category_image_Cell = (tableView.dequeueReusableCell(withIdentifier: "Cate_Img_Cell") as! Category_Image_cell)
                return self.category_image_Cell!
            case 3:
                self.numberCell = (tableView.dequeueReusableCell(withIdentifier: "NumberCell") as! NumberCell)
                return self.numberCell!
            case 4:
                self.amountCell = (tableView.dequeueReusableCell(withIdentifier: "AmountCell") as! AmountCell)
                return self.amountCell!                
            default:
                fatalError()
            }
        case 1:
            self.memoCell = (tableView.dequeueReusableCell(withIdentifier: "MemoCell") as! MemoCell)
            return self.memoCell!
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 2{
                return ViewProperties.cellHeight*3
            }else{
                return ViewProperties.cellHeight
            }
        case 1:
            let cell = MemoCell()
            return cell.frame.height
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

