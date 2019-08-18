//
//  add_StockListView.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class add_StockListView: SuperViewController_Details {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //cellの登録
        self.tableView.register(NameCell_add.self, forCellReuseIdentifier: "NameCell")
        self.tableView.register(ExpDateCell.self, forCellReuseIdentifier: "ExpDateCell")
        self.tableView.register(Category_Image_cell.self, forCellReuseIdentifier: "Cate_Img_Cell")
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell") as! NameCell_add
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExpDateCell") as! ExpDateCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cate_Img_Cell") as! Category_Image_cell
                return cell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2{
            return ViewProperties.cellHeight*3
        } else {
            return ViewProperties.cellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
