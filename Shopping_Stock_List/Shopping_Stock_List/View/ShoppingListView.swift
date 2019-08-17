//
//  ShoppingListView.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/06.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class ShoppingListView: SuperViewController_List {

    
    override func viewWillAppear(_ animated: Bool) {
        print("ShoppingList画面が再表示されました。")
        ListArray = ListArrayClass.ShoppingListArray
        tableView.reloadData()
    }
    
    var ListArray:[ShoppingDataClass] = []
    
    //cellの表示設定
    override func CellView(indexpathRow:Int) -> UIView {
        let cellName = ListArray[indexpathRow].Name
        let cell_view:UIView = ViewProperties.stockCellView(name: cellName, date: "2019/08/15")
        return cell_view
    }
    //section内のcell数
    override func numberOfRowsInSection() -> Int {
        return ListArray.count
    }
    
    //データ削除
    override func deleteData(indexpath:IndexPath){
        ListArray.remove(at: indexpath.row)
        tableView.deleteRows(at: [indexpath], with: .bottom)
        SaveDataClass.SaveData(inputData: ListArray, KeyName: "ShoppingData")
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
