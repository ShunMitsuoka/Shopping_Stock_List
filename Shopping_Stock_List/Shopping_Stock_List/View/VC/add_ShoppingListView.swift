//
//  add_ShoppingListView.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/10/17.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class add_ShoppingListView: SuperVC_StockDetails {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.nameCell_add = (tableView.dequeueReusableCell(withIdentifier: "NameCell") as! NameCell_add)
                return self.nameCell_add!
            case 1:
                self.numberCell = (tableView.dequeueReusableCell(withIdentifier: "NumberCell") as! NumberCell)
                return self.numberCell!
            case 2:
                self.category_image_Cell = (tableView.dequeueReusableCell(withIdentifier: "Cate_Img_Cell") as! Category_Image_cell)
                self.category_image_Cell?.imageview?.setImageOnSelf(image: UIImage(named: "no_Image")!)
                return self.category_image_Cell!
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
                return ViewProperties.imageCellHeight
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
            return 3
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    //追加ボタンを押された際に遷移するかどうか判断
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "unwind_fromShoppingToAdd"{
            name = nameCell_add!.textField.text
            category = category_image_Cell!.categoryView!.category
            image = category_image_Cell!.imageview!.image
            if let num = numberCell!.NumberField.text{
                number = Double(num)
            }else{
                number = nil
            }
            memo = memoCell!.textView.text
            //nameは必要
            if (name == nil || name == "") {
                //alert表示
                Error_Alert.ShowAlert(ViewController: self, title: "", message: "VC100_Name".localized )
                return false
            }else{
                return true
            }
        }
        return true
    }
    
    //遷移する際の動作
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "unwind_fromShoppingToAdd"{
            print("データを追加します。")
            SaveDataClass.add_ShoppingData(Name: name, Category: category, Number: number, Image: image, Memo: memo)
        }
    }

}
