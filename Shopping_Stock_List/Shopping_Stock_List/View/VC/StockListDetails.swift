//
//  StockListDetails.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/24.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class StockListDetails: SuperVC_StockDetails {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let Data = receiveData!
    }
    
    //受け取る変数
    var receiveData:StockDataClass!
    var receiveIndexpath:IndexPath!
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.nameCell_add = (tableView.dequeueReusableCell(withIdentifier: "NameCell") as! NameCell_add)
                self.nameCell_add!.textField.text = receiveData.Name
                return self.nameCell_add!
            case 1:
                self.expDateCell = (tableView.dequeueReusableCell(withIdentifier: "ExpDateCell") as! ExpDateCell)
                if receiveData.ExpDate == "nil" || receiveData.ExpDate == nil  {
                    self.expDateCell?.DateField.text = nil
                    self.expDateCell?.date = "nil"
                    return self.expDateCell!
                }else{
                    self.expDateCell?.DateField.text = receiveData.ExpDate
                    self.expDateCell?.date = receiveData.ExpDate
                    return self.expDateCell!
                }
            case 2:
                self.category_image_Cell = (tableView.dequeueReusableCell(withIdentifier: "Cate_Img_Cell") as! Category_Image_cell)
                self.category_image_Cell?.categoryView?.identfierID = 1
                self.category_image_Cell?.categoryView?.setCategoryName = receiveData.Category
                self.category_image_Cell?.categoryView?.category = receiveData.Category
                return self.category_image_Cell!
            case 3:
                self.numberCell = (tableView.dequeueReusableCell(withIdentifier: "NumberCell") as! NumberCell)
                if receiveData.Number == -9999 || receiveData.Number == nil{
                    self.numberCell?.NumberField.text = nil
                    return self.numberCell!
                }else{
                    self.numberCell?.NumberField.text = String(receiveData.Number!)
                    return self.numberCell!
                }
                
            case 4:
                self.amountCell = (tableView.dequeueReusableCell(withIdentifier: "AmountCell") as! AmountCell)
                if receiveData.Amount == -999 || receiveData.Amount == nil{
                    self.amountCell?.amountValue = nil
                    return self.amountCell!
                }else{
                    print("amountValueがあります。")
                    self.amountCell?.amountSlider.value = Float(receiveData.Amount!)
                    self.amountCell?.amountValue = receiveData.Amount!
                    self.amountCell?.setColorBar(value: CGFloat(receiveData.Amount!))
                    return self.amountCell!
                }
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

    
    //追加ボタンを押された際に遷移するかどうか判断
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        name = nameCell_add!.textField.text
        expDate = expDateCell!.date
        category = category_image_Cell!.categoryView!.category
        image = category_image_Cell!.imageview!.image
        if let num = numberCell!.NumberField.text{
            number = Double(num)
        }else{
            number = nil
        }
        amount = amountCell!.amountValue
        memo = memoCell!.textView.text
        
        if identifier == "unwind_fromDetailsToAdd"{
            print("unwind呼ばれた")
            //nameは必要
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
        if segue.identifier == "unwind_fromDetailsToAdd"{
            print("データを保存します。")
            let StockVC = segue.destination as! StockListView
            StockVC.receive_indexPath = self.receiveIndexpath
            StockVC.receive_data = StockDataClass(Name: name, Category: category, Number: number, Image: "", Memo: memo, ExpDate: expDate, Amount: amount)
        }
    }

}
