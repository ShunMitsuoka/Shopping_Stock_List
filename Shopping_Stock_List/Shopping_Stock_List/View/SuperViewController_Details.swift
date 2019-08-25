//
//  SuperViewController_Details.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class SuperViewController_Details: SuperViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //tableView設定
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
    
    //cellの設定
    var nameCell_add:NameCell_add?
    var expDateCell:ExpDateCell?
    var category_image_Cell:Category_Image_cell?
    var numberCell:NumberCell?
    var amountCell:AmountCell?
    var memoCell:MemoCell?
    
    //変数の設定
    var name:String!
    var expDate:String?
    var category:String!
    var image:UIImage?
    var number:Double?
    var amount:Double?
    var memo:String?
    
    var tabelViewHeight:CGFloat{
        get{
            return ViewProperties.mainBoundSize.height - navigationHeight
        }
    }
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = UIView()
        headerview.frame.size = CGSize(width: ViewProperties.mainBoundSize.width, height: 30 )
        headerview.backgroundColor = UIColor(red: 189/255, green: 140/255, blue: 102/255, alpha: 1)
        let headerLabel = UILabel(frame: CGRect(x:10, y: -1, width: mainBoundSize.width, height: 30))
        headerLabel.font = UIFont.systemFont(ofSize: 25)
        headerview.addSubview(headerLabel)
        if section == 0 {
            headerLabel.text = ""
        } else if section == 1{
            headerLabel.text = "Memo"
        }
        return headerview
    }
    
}
