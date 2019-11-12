//
//  add_StockListView.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class add_StockListView: SuperVC_StockDetails {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    //追加ボタンを押された際に遷移するかどうか判断
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "unwind_fromStockToAdd"{
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
        if segue.identifier == "unwind_fromStockToAdd"{
            print("データを追加します。")
            SaveDataClass.add_StockData(Name: name, Category: category, Number: number, Image: image, Memo: memo, ExpDate: expDate, Amount: amount)
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
