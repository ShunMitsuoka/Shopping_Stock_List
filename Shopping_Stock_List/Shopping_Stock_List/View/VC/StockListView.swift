//
//  StockListView.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class StockListView: SuperViewController_List {
    
    
    override func viewDidLoad() {
        self.customReloadData()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addButton.frame = CGRect(x: 0,y: 0 , width: 90, height: 90)
        addButton.layer.position = CGPoint(x: ViewProperties.mainBoundSize.width - 30, y: ViewProperties.mainBoundSize.height - tabBarHeight - 30)
        addButton.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(addButton)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("StockList画面が再表示されました。")
        self.customReloadData()
    }
    
    var ListArray:[StockDataClass] = []
    var ListArray_category:[[StockDataClass]] = [[]]
    var addButton = UIButton(type: .contactAdd)
    var receive_indexPath:IndexPath?
    var receive_data:StockDataClass?
    
    //cellの表示設定
    override func CellView(indexpath:IndexPath) -> UIView {
        let cellName = ListArray_category[indexpath.section][indexpath.row].Name
        let cellDate = ListArray_category[indexpath.section][indexpath.row].ExpDate
        let cellAmount = ListArray_category[indexpath.section][indexpath.row].Amount
        let cell_view:UIView = stockCellView(name: cellName, date: cellDate, amount: cellAmount)
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
        ListArray = Array_order_return(Array: ListArray_category)
        SaveDataClass.SaveData(inputData: ListArray, KeyName: "StockData")
        
    }
    
//    //データの整理
//    func ArrangeData(){
//        ListArray = ListArrayClass.StockListArray
//        ListArray_category = Array_order(ListArray: ListArray)
//        ListArray = Array_order_return(Array: ListArray_category)
//        SaveDataClass.SaveData(inputData: ListArray, KeyName: "StockData")
//    }
    
    //ボタンが押された時
    @objc func buttonEvent(_ sender: UIButton) {
        performSegue(withIdentifier: "fromStockToAdd", sender: nil)
        print("ボタンの情報: \(sender)")
    }
    
    
    //segue設定
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "fromStockToAdd":
            return
        case "fromStockToDetail":
            let sender = sender as! (StockDataClass, IndexPath)
            let DetailsVC = segue.destination as! StockListDetails
            let data:StockDataClass = sender.0
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
        case "unwind_fromStockToAdd":
            print("unwind")
        case "unwind_fromDetailsToAdd":
            if let data = receive_data{
                if let indexPath = receive_indexPath{
                    ListArray_category = Array_order(ListArray: ListArrayClass.StockListArray)
                    //カテゴリーに変更があったか確認
                    //無ければ同じ場所に、あればそのカテゴリーの最後に要素を追加
                    if CategoryClass.CategoryArray[indexPath.section] == data.Category{
                        ListArray_category[indexPath.section][indexPath.row] = data
                    }else{
                        ListArray_category[indexPath.section].remove(at: indexPath.row)
                        let add_indexPath = CategoryClass.CategoryIndex(categoryName: data.Category)
                        ListArray_category[add_indexPath].append(data)
                    }
                    ListArray = Array_order_return(Array: ListArray_category)
                    SaveDataClass.SaveData(inputData: ListArray, KeyName: "StockData")
                    tableView.reloadData()
                }
            }
            print("unwind")
        default:
            fatalError()
        }
    }
    
    //reload設定
    override func customReloadData(){
        ListArray_category = Array_order(ListArray: ListArrayClass.StockListArray)
        ListArray = Array_order_return(Array: ListArray_category)
        SaveDataClass.SaveData(inputData: ListArray, KeyName: "StockData")
        tableView.reloadData()
    }
    
    //cell選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data:StockDataClass = ListArray_category[indexPath.section][indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        if cell != nil {
            performSegue(withIdentifier: "fromStockToDetail", sender: (data,indexPath))
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
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
