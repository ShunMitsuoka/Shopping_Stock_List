//
//  SuperViewController_List.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/17.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class SuperViewController_List: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = ViewProperties.backgroundColor
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
    
    //cellの表示設定
    func CellView(indexpathRow:Int) -> UIView{
        let View = UIView()
        return View
    }
    
    //section内のcell数
    func numberOfRowsInSection() -> Int{
        return 0
    }
    
    //データ削除
    func deleteData(indexpath:IndexPath){}
    
    

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
        return numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell_List", for: indexPath)
        cell.backgroundColor = ViewProperties.CellColor(indexpath: indexPath.row)!
        cell.addSubview(CellView(indexpathRow: indexPath.row))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CategoryClass.CategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewProperties.cellHeight
    }
    
    //cellのdelete操作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        //データ削除
        if editingStyle == .delete{
            deleteData(indexpath: indexPath)
            tableView.reloadData()
        }
    }

    
}

extension SuperViewController_List:UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ViewProperties.headerView(section: section)
    }
    
}

