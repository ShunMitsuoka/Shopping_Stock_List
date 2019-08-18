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
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addButton.frame = CGRect(x: 0,y: 0 , width: 90, height: 90)
        addButton.layer.position = CGPoint(x: ViewProperties.mainBoundSize.width - 30, y: ViewProperties.mainBoundSize.height - tabBarHeight - 30)
        addButton.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(addButton)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("StockList画面が再表示されました。")
        ListArray = ListArrayClass.StockListArray
        tableView.reloadData()
    }
    
    var ListArray:[StockDataClass] = []
    var addButton = UIButton(type: .contactAdd)
    
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
        SaveDataClass.SaveData(inputData: ListArray, KeyName: "StockData")
    }
    
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
        default:
            print("存在しないsegueIdentfierです。")
            fatalError()
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
