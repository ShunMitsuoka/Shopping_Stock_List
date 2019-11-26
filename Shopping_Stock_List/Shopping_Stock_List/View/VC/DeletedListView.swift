//
//  DeletedListView.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/10/23.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class DeletedListView: SuperViewController_List {

    override func viewDidLoad() {
        self.customReloadData()
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: "setting")
        let reSizeImage = image?.reSizeImage(reSize: naviBarImageSize)
        SettingBtnItem.image = reSizeImage?.withRenderingMode(.alwaysOriginal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DeletedList画面が再表示されました。")
        self.customReloadData()
    }
    
    var ListArray:[DeletedDataClass] = []
    var ListArray_category:[[DeletedDataClass]] = [[]]
    @IBOutlet weak var SettingBtnItem: UIBarButtonItem!
    
    //Reload設定
    override func customReloadData(){
        ListArray_category = Array_order(ListArray: ListArrayClass.DeletedListArray) as! [[DeletedDataClass]]
        ListArray = Array_order_return(Array: ListArray_category) as! [DeletedDataClass]
        SaveDataClass.SaveData(inputData: ListArray, KeyName: "DeletedData")
        tableView.reloadData()
    }
    
    
    //cellの表示設定
    override func CellView(indexpath:IndexPath) -> UIView {
        let Name = ListArray_category[indexpath.section][indexpath.row].Name
        let Number:Double? = nil
        let cell_view:UIView = shoppingCellView(name: Name, number: Number)
        return cell_view
    }
    
    //section内のcell数
    override func numberOfRowsInSection(section:Int) -> Int {
        return ListArray_category[section].count
    }
    
    //データ削除
    override func deleteData(indexpath:IndexPath){
        ListArray_category[indexpath.section].remove(at: indexpath.row)
        tableView.deleteRows(at: [indexpath], with: .bottom)
        ListArray = Array_order_return(Array: ListArray_category) as! [DeletedDataClass]
        SaveDataClass.SaveData(inputData: ListArray, KeyName: "DeletedData")
    }
    
    ///swipe
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        ///選択されたデータ取得
        let sendData = self.ListArray_category[indexPath.section][indexPath.row]
        ///買い物リストへ
        let sendShoppingList_Action = UIContextualAction(style: .destructive, title: "買い物リストへ", handler:
        {(action:UIContextualAction,view:UIView,completion:(Bool) -> Void) in
            let ShoppingData = self.DeletedToShopping(DeletedData: sendData)
            ListArrayClass.appendData(appendData: ShoppingData)
            ///データを削除
            self.deleteData(indexpath: indexPath)
            completion(true)
        })
        sendShoppingList_Action.backgroundColor = UIColor.blue
        return UISwipeActionsConfiguration(actions: [sendShoppingList_Action])
    }
    
    
}
