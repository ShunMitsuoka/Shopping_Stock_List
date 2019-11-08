//
//  ShoppingListView.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/06.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class ShoppingListView: SuperViewController_List {
    
    override func viewDidLoad() {
        self.customReloadData()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addButton.frame = CGRect(x: 0,y: 0 , width: 50, height: 50)
        addButton.layer.position = CGPoint(x: ViewProperties.mainBoundSize.width - 50, y: ViewProperties.mainBoundSize.height - tabBarHeight - 40)
        addButton.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
        addButton.setImage(UIImage(named: "add_btn"), for: .normal)
        addButton.imageView?.contentMode = .scaleAspectFit
        
        self.view.addSubview(addButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        print("ShoppingList画面が再表示されました。")
        self.customReloadData()
    }

    var ListArray:[ShoppingDataClass] = []
    var ListArray_category:[[ShoppingDataClass]] = [[]]
    var addButton = UIButton(type: .custom)
    var receive_indexPath:IndexPath?
    var receive_data:ShoppingDataClass?
    
    //ボタンが押された時
    @objc func buttonEvent(_ sender: UIButton) {
        performSegue(withIdentifier: "fromShoppingToAdd", sender: nil)
        print("ボタンの情報: \(sender)")
    }
    
    //Reload設定
    override func customReloadData(){
        ListArray_category = Array_order(ListArray: ListArrayClass.ShoppingListArray) as! [[ShoppingDataClass]]
        ListArray = Array_order_return(Array: ListArray_category) as! [ShoppingDataClass]
        SaveDataClass.SaveData(inputData: ListArray, KeyName: "ShoppingData")
        tableView.reloadData()
    }
    

    //cellの表示設定
    override func CellView(indexpath:IndexPath) -> UIView {
        let Name = ListArray_category[indexpath.section][indexpath.row].Name
        let Number:Double? = ListArray_category[indexpath.section][indexpath.row].Number
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
        ListArray = Array_order_return(Array: ListArray_category) as! [ShoppingDataClass]
        SaveDataClass.SaveData(inputData: ListArray, KeyName: "ShoppingData")
    }
    
    //cell選択時segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data:ShoppingDataClass = ListArray_category[indexPath.section][indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        if cell != nil {
            performSegue(withIdentifier: "fromShoppingToDetail", sender: (data,indexPath))
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //segue設定
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "fromShoppingToAdd":
            return
        case "fromShoppingToDetail":
            let sender = sender as! (ShoppingDataClass, IndexPath)
            let DetailsVC = segue.destination as! ShoppingListDetails
            let data:ShoppingDataClass = sender.0
            let indexPath:IndexPath = sender.1
            DetailsVC.receiveData = data
            DetailsVC.receiveIndexpath = indexPath
        default:
            print("存在しないsegueIdentfierです。")
            fatalError()
        }
    }
    
    //unwind設定
    @IBAction func unwindPrev(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        switch unwindSegue.identifier {
        case "unwind_fromShoppingToAdd":
            print("unwind")
        case "unwind_fromShoppingToDetail":
            if let data = receive_data{
                if let indexPath = receive_indexPath{
                    ListArray_category = Array_order(ListArray: ListArrayClass.ShoppingListArray) as! [[ShoppingDataClass]]
                    //カテゴリーに変更があったか確認
                    //無ければ同じ場所に、あればそのカテゴリーの最後に要素を追加
                    if CategoryClass.CategoryArray[indexPath.section] == data.Category{
                        ListArray_category[indexPath.section][indexPath.row] = data
                    }else{
                        ListArray_category[indexPath.section].remove(at: indexPath.row)
                        let add_indexPath = CategoryClass.CategoryIndex(categoryName: data.Category)
                        ListArray_category[add_indexPath].append(data)
                    }
                    ListArray = Array_order_return(Array: ListArray_category) as! [ShoppingDataClass]
                    SaveDataClass.SaveData(inputData: ListArray, KeyName: "ShoppingData")
                    tableView.reloadData()
                }
            }
            print("unwind")
        default:
            fatalError()
        }
    }
    
    ///swipe
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        ///選択されたデータ取得
        let sendData = self.ListArray_category[indexPath.section][indexPath.row]
        
        let sendDeletedList_Action = UIContextualAction(style: .destructive, title: "削除リストへ", handler:
        {(action:UIContextualAction,view:UIView,completion:(Bool) -> Void) in
            ///削除リストへ
            let deletedData = self.ShoppingToDeleted(ShoppingData: sendData)
            ListArrayClass.appendData(appendData: deletedData)
            ///データを削除
            self.deleteData(indexpath: indexPath)
            completion(true)
        })
        let sendStockList_Action = UIContextualAction(style: .destructive, title: "ストックリストへ", handler:
        {(action:UIContextualAction,view:UIView,completion:(Bool) -> Void) in
            ///ストックリストへ
            let StockData = self.ShoppingToStock(ShoppingData: sendData)
            ListArrayClass.appendData(appendData: StockData)
            ///データを削除
            self.deleteData(indexpath: indexPath)
            completion(true)
        })
        
        sendDeletedList_Action.backgroundColor = UIColor.orange
        sendStockList_Action.backgroundColor = UIColor.blue
        return UISwipeActionsConfiguration(actions: [sendDeletedList_Action,sendStockList_Action])
    }

}
