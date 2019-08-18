//
//  SuperViewController_Details.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class SuperViewController_Details: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = ViewProperties.backgroundColor
        //tableView設定
        let tabelViewHeight = ViewProperties.mainBoundSize.height - navigationHeight
        tableView.frame = CGRect(x: 0, y: navigationHeight, width: ViewProperties.mainBoundSize.width, height: tabelViewHeight)
        tableView.backgroundColor = ViewProperties.tableViewbackgroundColor
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SuperViewController_Details:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewProperties.cellHeight
    }
    
    
}

extension SuperViewController_Details:UITableViewDelegate{
    
}
