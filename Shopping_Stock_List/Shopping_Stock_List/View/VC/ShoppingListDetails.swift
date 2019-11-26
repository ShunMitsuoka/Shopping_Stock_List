//
//  ShoppingListDetails.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/10/23.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class ShoppingListDetails: add_ShoppingListView {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    ///segueの際に受け取る変数
    var receiveData:ShoppingDataClass!
    var receiveIndexpath:IndexPath!

    ///Cell表示
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.nameCell_add = (tableView.dequeueReusableCell(withIdentifier: "NameCell") as! NameCell_add)
                self.nameCell_add!.textField.text = receiveData.Name
                return self.nameCell_add!
            case 1:
                self.numberCell = (tableView.dequeueReusableCell(withIdentifier: "NumberCell") as! NumberCell)
                if receiveData.Number == nil{
                    self.numberCell?.NumberField.text = nil
                    return self.numberCell!
                }else{
                    self.numberCell?.NumberField.text = String(Int(receiveData.Number!))
                    return self.numberCell!
                }
            case 2:
                self.category_image_Cell = (tableView.dequeueReusableCell(withIdentifier: "Cate_Img_Cell") as! Category_Image_cell)
                self.category_image_Cell?.categoryView?.identfierID = 1
                self.category_image_Cell?.categoryView?.setCategoryName = receiveData.Category
                self.category_image_Cell?.categoryView?.category = receiveData.Category
                if let image = receiveData.Image{
                    self.category_image_Cell?.imageview?.setImageOnSelf(image: image)
                }
                return self.category_image_Cell!
            default:
                fatalError()
            }
        case 1:
            self.memoCell = (tableView.dequeueReusableCell(withIdentifier: "MemoCell") as! MemoCell)
            if receiveData.Memo == "" || receiveData.Memo == nil{
                self.memoCell?.textView.text = nil
                return self.memoCell!
            }else{
                self.memoCell?.textView.text = receiveData.Memo
                return self.memoCell!
            }
        default:
            fatalError()
        }
    }
    
    
    //遷移するかどうか判断
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        name = nameCell_add!.textField.text
        category = category_image_Cell!.categoryView!.category
        image = category_image_Cell!.imageview!.image
        if let num = numberCell!.NumberField.text{
            number = Double(num)
        }else{
            number = nil
        }
        memo = memoCell!.textView.text
        
        if identifier == "unwind_fromShoppingToDetail"{
            //nameは必須
            if (name == nil || name == "") {
                name = receiveData.Name
                return true
            }else{
                return true
            }
        }
        return false
    }
    
    //遷移する際の動作
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "unwind_fromShoppingToDetail"{
            print("データを保存します。")
            let ShoppingListVC = segue.destination as! ShoppingListView
            ShoppingListVC.receive_indexPath = self.receiveIndexpath
            ShoppingListVC.receive_data = ShoppingDataClass(Name: name, Category: category, Number: number, Image: image, Memo: memo)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
