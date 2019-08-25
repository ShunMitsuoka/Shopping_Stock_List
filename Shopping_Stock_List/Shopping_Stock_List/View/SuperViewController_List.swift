//
//  SuperViewController_List.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/17.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class SuperViewController_List: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        //tableView設定
        let tabelViewHeight = ViewProperties.mainBoundSize.height - navigationHeight - tabBarHeight
        tableView.frame = CGRect(x: 0, y: navigationHeight, width: ViewProperties.mainBoundSize.width, height: tabelViewHeight)
        tableView.backgroundColor = ViewProperties.tableViewbackgroundColor
        tableView.separatorStyle = .none
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //cellの登録
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell_List")
        
        //ViewにtableViewを追加
        view.addSubview(tableView)
        
        //再描写
        tableView.reloadData()
    }
    
    let tableView = UITableView()
    var navigationHeight:CGFloat!{
        get{
            return self.navigationController?.navigationBar.frame.size.height
        }
    }
    var tabBarHeight:CGFloat!{
        get{
            return self.tabBarController?.tabBar.frame.size.height
        }
    }
    
    //tableView再描写
    func customReloadData(){
        tableView.reloadData()
    }
    
    //cellの表示設定
    func CellView(indexpath:IndexPath) -> UIView{
        let View = UIView()
        return View
    }
    
    //section内のcell数
    func numberOfRowsInSection(section:Int) -> Int{
        return 0
    }
    
    //データ削除
    func deleteData(indexpath:IndexPath){}
    
    
    //Stock
    
    //内容表示
    func stockCellView(name:String, date:String?,amount:Double?) -> UIView{
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width, height: cellHeight))
        cellView.backgroundColor = UIColor.clear
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width*0.5, height: cellHeight))
        nameLabel.text = name
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: mainBoundSize.width*0.5/6)
        nameLabel.textAlignment = NSTextAlignment.center
        cellView.addSubview(nameLabel)
        if date != "nil" {
            let dateLabel = UILabel(frame: CGRect(x: mainBoundSize.width*0.5, y:0 , width: mainBoundSize.width*0.5, height: cellHeight))
            dateLabel.text = date
            dateLabel.textColor = UIColor.black
            dateLabel.textAlignment = NSTextAlignment.center
            dateLabel.font = UIFont.systemFont(ofSize: mainBoundSize.width*0.5/8 )
            cellView.addSubview(dateLabel)
        }
        
        //残量バーを表示しない
        if amount == -999 || amount == nil {
            let layer:CALayer =  CALayer()
            layer.frame = CGRect(x: 0, y: cellHeight*0.93 , width: mainBoundSize.width, height: cellHeight*0.07)
            layer.backgroundColor = UIColor(red: 68/255, green: 157/255, blue: 155/255, alpha: 1).cgColor
            cellView.layer.addSublayer(layer)
            return cellView
        }
        //残量バーを表示する
        let amountBar = CGRect(x: 0, y: 0 , width: mainBoundSize.width, height: cellHeight*0.07)
        let value:CGFloat = CGFloat(amount!)
        let mainWidth = ViewProperties.mainBoundSize.width
        let viewWidth:CGFloat = mainWidth * (value)/100
        let coverView:UIView = UIView(frame: CGRect(x: 0, y: cellHeight*0.93 , width: viewWidth, height: cellHeight*0.07))
        coverView.layer.addSublayer(ViewProperties.gradientLayer(frame: amountBar))
        coverView.clipsToBounds = true
        cellView.addSubview(coverView)
        return cellView
    }
    
    //リストの順番をカテゴリー毎に分ける。
    func Array_order(ListArray:[StockDataClass]) -> [[StockDataClass]]{
        var Array = [[]]
        let categoryArray = CategoryClass.CategoryArray
        var count = 0
        for category in categoryArray{
            Array.append([])
            for data in ListArray{
                if data.Category == category{
                    Array[count].append(data)
                }
            }
            count += 1
        }
        return Array as! [[StockDataClass]]
    }
    
    func Array_order_return(Array:[[StockDataClass]]) -> [StockDataClass]{
        var returnArray:Array<StockDataClass> = []
        for datas in Array{
            for data in datas{
                returnArray.append(data)
            }
        }
        return returnArray
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


extension SuperViewController_List:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell_List", for: indexPath)
        //サブビューを一度全て削除
        let subviews = cell.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        cell.backgroundColor = ViewProperties.CellColor(indexpath: indexPath.row)!
        cell.addSubview(CellView(indexpath: indexPath))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CategoryClass.CategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    //cellのdelete操作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        //データ削除
        if editingStyle == .delete{
            deleteData(indexpath: indexPath)
            customReloadData()
        }
    }

    
}

extension SuperViewController_List:UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ViewProperties.headerView(section: section)
    }
    
}

